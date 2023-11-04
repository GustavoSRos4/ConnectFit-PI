<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Contrato;
use App\Models\PessoaProfissional;
use Illuminate\Http\Request;
use Carbon\Carbon;

use Illuminate\Support\Facades\Log;

class ContratoController extends Controller
{
    public function create(Request $request)
    {
        $userId = (auth('api')->user()->id);
        $request->validate([
            'idPessoaProfissional' => 'required|integer',
            'idDuracao' => 'required|integer',
        ]);

        try {

            $idPessoaProfissional = $request->input('idPessoaProfissional');
            $valor = PessoaProfissional::where('idPessoaProfissional', $idPessoaProfissional)->value('valor');
            $contrato = new Contrato();
            $contrato->idPessoaUsuario = $userId;
            $contrato->idPessoaProfissional = $request->input('idPessoaProfissional');
            $contrato->valor = $valor;
            $contrato->dataInic = Carbon::now();
            $contrato->idDuracao = $request->input('idDuracao');

            $contrato->save();

            return response()->json(['message' => 'Contrato criado com sucesso'], 201);
        } catch (\Exception $e) {
            Log::error($e);

            return response()->json(['message' => 'Falha ao criar contrato'], 500);
        }
    }
}
