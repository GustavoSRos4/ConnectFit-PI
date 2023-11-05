<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Comorbidade;
use App\Models\ConsumoAlc;
use App\Models\Fumante;
use App\Models\PessoaMedicamento;
use App\Models\PessoaUsuario;
use App\Models\Medicamento;
use App\Models\NivelAtiFisica;
use App\Models\Objetivo;
use App\Models\PessoaComorbidades;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class PessoaUsuarioController extends Controller
{
    public function create(Request $request)
    {
        $userId = auth('api')->user()->id;

        $request->validate([
            'altura' => 'required|integer',
            'idFumante' => 'required|integer',
            'idNivelAtiFis' => 'required|integer',
            'idObjetivo' => 'required|integer',
            'idConsumoAlc' => 'required|integer',
        ]);

        DB::beginTransaction();
        try {
            $person = new PessoaUsuario();
            $person->idPessoaUsuario = $userId;
            $person->Altura = $request->input('altura');
            $person->idFumante = $request->input('idFumante');
            $person->idNivelAtiFis = $request->input('idNivelAtiFis');
            $person->idObjetivo = $request->input('idObjetivo');
            $person->idConsumoAlc = $request->input('idConsumoAlc');
            $person->save();
            $medicamentos = json_decode($request->input('Medicamentos'));
            if (!empty($medicamentos) && is_array($medicamentos)) {
                foreach ($medicamentos as $medicamentoData) {
                    $existingMedicamento = Medicamento::where('descricao', $medicamentoData->descricao)->first();

                    if ($existingMedicamento) {
                        $medicamentoId = $existingMedicamento->idMedicamento;
                    } else {
                        $medicamento = new Medicamento();
                        $medicamento->descricao = $medicamentoData->descricao;
                        $medicamento->save();
                        $medicamentoId = $medicamento->idMedicamento;
                    }
                    $pessoaMedicamentos = new PessoaMedicamento();
                    $pessoaMedicamentos->idPessoaUsuario = $userId;
                    $pessoaMedicamentos->idMedicamento = $medicamentoId;
                    $pessoaMedicamentos->save();
                }
            }
            $comorbidades = json_decode($request->input('Comorbidades'));
            if (!empty($comorbidades) && is_array($comorbidades)) {
                foreach ($comorbidades as $comorbidadeData) {
                    $existingComorbidade = Comorbidade::where('descricao', $comorbidadeData->descricao)->first();

                    if ($existingComorbidade) {
                        $comorbidadeId = $existingComorbidade->idComorbidade;
                    } else {
                        $comorbidade = new Comorbidade();
                        $comorbidade->descricao = $comorbidadeData->descricao;
                        $comorbidade->save();
                        $comorbidadeId = $comorbidade->idComorbidade;
                    }
                    $pessoaComorbidades = new PessoaComorbidades();
                    $pessoaComorbidades->idPessoaUsuario = $userId;
                    $pessoaComorbidades->idComorbidade = $comorbidadeId;
                    $pessoaComorbidades->save();
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
    public function anamneseData()
    {
        $consumoAlcs = ConsumoAlc::all();
        $objetivos = Objetivo::all();
        $nivelAtiFiss = NivelAtiFisica::all();
        $fumantes = Fumante::all();
        return response()->json(['ConsumoAlc' => $consumoAlcs, 'Objetivos' => $objetivos, 'nivelAtiFis' => $nivelAtiFiss, 'Fumante' => $fumantes], 200);
    }
}
