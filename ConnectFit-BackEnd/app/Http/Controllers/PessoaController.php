<?php

namespace App\Http\Controllers;

use App\Models\Comorbidade;
use App\Models\EnderecoPessoa;
use App\Models\Pessoa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Models\Telefone;
use App\Models\Endereco;
use App\Models\PessoaComorbidades;

class PessoaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $userId = (auth('api')->user()->id);
        $request->validate([
            'cpf' => 'required|integer',
            'descricao' => 'nullable|string',
            'dataNas' => 'required|date',
        ]);

        try {
            $person = new Pessoa();
            $person->idPessoa = $userId;
            $person->cpf = $request->input('cpf');
            $person->descricao = $request->input('descricao');
            $person->dataNas = $request->input('dataNas');

            $person->save();

            return response()->json(['message' => 'Pessoa criada com sucesso'], 201);
        } catch (\Exception $e) {
            Log::error($e);

            return response()->json(['message' => 'Falha ao criar a pessoa'], 500);
        }
    }

    public function show()
    {
        $user = auth('api')->user();
        if ($user) {
            $pessoa = Pessoa::where('idPessoa', $user->id)->first();
            $telefone = Telefone::where('idPessoaTelefone', $user->id)->first();
            $enderecosPessoa = EnderecoPessoa::where('idPessoa', $user->id)->get();
            $enderecos = [];
            foreach ($enderecosPessoa as $enderecoPessoa) {
                $endereco = Endereco::where('idEndereco', $enderecoPessoa->idEndereco)->get();
                $enderecos[] = $endereco;
            }
            return response()->json(['user' => $user, 'pessoa' => $pessoa, 'telefone' => $telefone, 'endereco' => $enderecos], 200);
        } else {
            return response()->json(['message' => 'Nenhuma pessoa associada a este usuário'], 404);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
