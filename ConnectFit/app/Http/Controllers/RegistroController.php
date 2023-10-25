<?php

namespace App\Http\Controllers;

use App\Models\Endereco;
use App\Models\EnderecoPessoa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Models\Pessoa;
use App\Models\Telefone;

class RegistroController extends Controller
{
    public function create(Request $request)
    {
        $userId = (auth('api')->user()->id);
        $request->validate([
            'cpf' => 'required|integer|unique:pessoas',
            'descricao' => 'nullable|string|max:500',
            'dataNas' => 'required|date',
            'ddd' => 'required',
            'numeroTel' => 'required|integer',
            'logradouro' => 'required|string|max:150',
            'numeroEnd' => 'required',
            'complemento' => 'nullable|string|max:15',
            'cep' => 'required|integer',
            'bairro' => 'required|string|max:50',
            'idCidade' => 'required',
            'SiglaSexo' => 'required',
        ]);

        try {
            $person = new Pessoa();
            $person->idPessoa = $userId;
            $person->cpf = $request->input('cpf');
            $person->descricao = $request->input('descricao');
            $person->dataNas = $request->input('dataNas');
            $person->SiglaSexo = $request->input('SiglaSexo');
            $person->save();
        } catch (\Exception $e) {
            Log::error($e);

            return response()->json(['message' => 'Falha no cadastro da Pessoa'], 500);
        }
        try {
            $fone = new Telefone();
            $fone->idPessoaTelefone = $userId;
            $fone->ddd = $request->input('ddd');
            $fone->numero = $request->input('numeroTel');
            $fone->save();
        } catch (\Exception $e) {
            Log::error($e);

            return response()->json(['message' => 'Falha no cadastro do telefone'], 500);
        }
        try {
            $address = Endereco::where('logradouro', $request->input('logradouro'))
                ->where('numero', $request->input('numeroEnd'))
                ->where('complemento', $request->input('complemento'))
                ->where('cep', $request->input('cep'))
                ->where('bairro', $request->input('bairro'))
                ->where('idCidade', $request->input('idCidade'))
                ->first();

            if ($address) {
                $addressId = $address->idEndereco;
            } else {
                $address = new Endereco();
                $address->idCidade = $request->input('idCidade');
                $address->logradouro = $request->input('logradouro');
                $address->numero = $request->input('numeroEnd');
                $address->complemento = $request->input('complemento');
                $address->cep = $request->input('cep');
                $address->bairro = $request->input('bairro');
                $address->save();
                $addressId = $address->idEndereco;
            }
        } catch (\Exception $e) {
            Log::error($e);

            return response()->json(['message' => 'Falha no cadastro do Endereco'], 500);
        }
        try {
            $address = Endereco::where('logradouro', $request->input('logradouro'))
                ->where('numero', $request->input('numeroEnd'))
                ->where('complemento', $request->input('complemento'))
                ->where('cep', $request->input('cep'))
                ->where('bairro', $request->input('bairro'))
                ->where('idCidade', $request->input('idCidade'))
                ->first();
            $addressId = $address->idEndereco;
            $addressPerson = new EnderecoPessoa();
            $addressPerson->idPessoa = $userId;
            $addressPerson->idEndereco = $addressId;
            $addressPerson->save();

            return response()->json(['message' => 'Cadastrado com sucesso'], 201);
        } catch (\Exception $e) {
            Log::error($e);

            return response()->json(['message' => 'Falha no cadastro do enderecoPessoa'], 500);
        }
    }

    public function update(Request $request)
    {
    }
}
