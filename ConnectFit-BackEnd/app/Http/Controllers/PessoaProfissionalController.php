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
            'descricao' => 'required|string',
        ]);

        DB::beginTransaction();
        try {
            $person = new PessoaProfissional();
            $person->idPessoaProfissional = $userId;
            $person->numReg = $request->input('numReg');
            $person->dataFormacao = $request->input('dataFormacao');
            $person->valor = $request->input('valor');
            $person->save();

            $espec = new Especialidade();
            $espec->descricao = $request->input('descricao');
            $espec->save();

            $especProf = new EspecialidadeProfissional();
            $especProf->idPessoaProfissional = $userId;
            $especProf->idEspecialidade = $espec->idEspecialidade;
            $especProf->save();
            DB::commit();
            return response()->json(['message' => 'Cadastrado com sucesso'], 201);
        } catch (\Exception $e) {
            DB::rollback();
            Log::error($e);

            return response()->json(['message' => 'Falha no cadastro', 'error' => $e->getMessage()], 500);
        }
    }
}
