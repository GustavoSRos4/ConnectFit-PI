<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Contrato;
use App\Models\Duracao;
use App\Models\PessoaProfissional;
use App\Models\PessoaUsuario;
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
    public function show()
    {

        $userId = auth('api')->user()->id;
        $contratos = Contrato::where('idPessoaUsuario', $userId)->orderBy('dataInic', 'desc')->get();
        return response()->json(['Contrato' => $contratos], 200);
    }
    public function showDuracao()
    {
        $duracao = Duracao::all();
        return response()->json(['Duracao' => $duracao], 200);
    }
}
