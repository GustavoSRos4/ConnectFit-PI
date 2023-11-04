<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Especialidade;
use App\Models\EspecialidadeProfissional;
use App\Models\PessoaProfissional;
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
}
