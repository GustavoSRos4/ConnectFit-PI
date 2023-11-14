<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Endereco;
use App\Models\EnderecoPessoa;
use App\Models\Especialidade;
use App\Models\EspecialidadeProfissional;
use App\Models\Pessoa;
use App\Models\PessoaProfissional;
use App\Models\Telefone;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class PessoaProfissionalController extends Controller
{
    public function create(Request $request)
    {
        $userId = auth('api')->user()->id;

        $request->validate([
            'numReg' => 'nullable|string',
            'dataFormacao' => 'required|date',
            'valor' => 'required|decimal:2',
        ]);

        DB::beginTransaction();
        try {
            $person = new PessoaProfissional();
            $person->idPessoaProfissional = $userId;
            $person->numReg = $request->input('numReg');
            $person->dataFormacao = $request->input('dataFormacao');
            $person->valor = $request->input('valor');
            $person->save();

            $especs = json_decode($request->input('Especialidades'));
            if (!empty($especs) && is_array($especs)) {
                foreach ($especs as $especData) {
                    $existingEspec = Especialidade::where('descricao', $especData->descricao)->first();

                    if ($existingEspec) {
                        $especId = $existingEspec->idEspecialidade;
                    } else {
                        $espec = new Especialidade();
                        $espec->descricao = $especData->descricao;
                        $espec->save();
                        $especId = $espec->idEspecialidade;
                    }
                    $especProf = new EspecialidadeProfissional();
                    $especProf->idPessoaProfissional = $userId;
                    $especProf->idEspecialidade = $especId;
                    $especProf->save();
                }
            }
            DB::commit();
            return response()->json(['message' => 'Cadastrado com sucesso'], 201);
        } catch (\Exception $e) {
            DB::rollback();
            Log::error($e);

            return response()->json(['message' => 'Falha no cadastro', 'error' => $e->getMessage()], 500);
        }
    }
    public function showDataPessoaProfissional()
    {

        $userId = auth('api')->user()->id;
        $pessoa = PessoaProfissional::where('idPessoaProfissional', $userId)->first();
        $especialidadeProfissionais = EspecialidadeProfissional::where('idPessoaProfissional', $userId)->get();
        $especialidades = [];
        foreach ($especialidadeProfissionais as $especialidadeProfissional) {
            $especialidade = Especialidade::where('idEspecialidade', $especialidadeProfissional->idEspecialidade)->get();
            $especialidades[] = $especialidade;
        }
        return response()->json(['PessoaProfissional' => $pessoa, 'Especialidades' => $especialidades], 200);
    }
    public function showAllProfissionais()
    {
        $profissionais = PessoaProfissional::where('ativo', 1)->get();
        $profissionaisResult = [];
        foreach ($profissionais as $profissional) {
            $idProfissional = $profissional->idPessoaProfissional;
            $user = User::where('id', $idProfissional)->first();
            $especialidadeProfissionais = EspecialidadeProfissional::where('idPessoaProfissional', $idProfissional)->get();
            $especialidades = [];
            $profissionalResult = [];
            foreach ($especialidadeProfissionais as $especialidadeProfissional) {
                $especialidade = Especialidade::where('idEspecialidade', $especialidadeProfissional->idEspecialidade)->get();
                $especialidades[] = $especialidade;
            }
            $profissionalResult[] = [
                'User' => $user,
                'PessoaProfissional' => $profissional,
                'Especialidades' => $especialidades,
            ];
        }
        $profissionaisResult[] = [
            'Profissional' => $profissionalResult,
        ];
        return response()->json(['PessoaProfissionais' => $profissionaisResult]);
    }
    public function showDataProfissional($idProfissional)
    {
        $user = User::where('id', $idProfissional)->first();
        $pessoa = Pessoa::where('idPessoa', $idProfissional)->first();
        $telefone = Telefone::where('idPessoaTelefone', $idProfissional)->first();
        $enderecosPessoa = EnderecoPessoa::where('idPessoa', $idProfissional)->get();
        $enderecos = [];
        foreach ($enderecosPessoa as $enderecoPessoa) {
            $endereco = Endereco::where('idEndereco', $enderecoPessoa->idEndereco)->get();
            $enderecos[] = $endereco;
        }
        $pessoaProfissional = PessoaProfissional::where('idPessoaProfissional', $idProfissional)->first();
        $especialidadeProfissionais = EspecialidadeProfissional::where('idPessoaProfissional', $idProfissional)->get();
        $especialidades = [];
        foreach ($especialidadeProfissionais as $especialidadeProfissional) {
            $especialidade = Especialidade::where('idEspecialidade', $especialidadeProfissional->idEspecialidade)->get();
            $especialidades[] = $especialidade;
        }
        return response()->json([
            'User' => $user,
            'Pessoa' => $pessoa,
            'Telefone' => $telefone,
            'Enderecos' => $enderecos,
            'PessoaProfissional' => $pessoaProfissional,
            'Especialidades' => $especialidades,
        ], 200);
    }
}
