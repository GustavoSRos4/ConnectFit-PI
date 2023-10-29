<?php

namespace App\Http\Controllers;

use App\Models\Pessoa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;


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
            $person->user_id = $userId;
            $person->cpf = $request->input('cpf');
            $person->descricao = $request->input('descricao');
            $person->dataNas = $request->input('dataNas');

            $person->save();

            return response()->json(['message' => 'Person created successfully'], 201);
        } catch (\Exception $e) {
            Log::error($e);

            return response()->json(['message' => 'Failed to create person'], 500);
        }
    }

    public function show(Request $request)
    {
        $user = auth('api')->user();
        if ($user->pessoa) {
            return response()->json(['data' => $user->pessoa], 200);
        } else {
            return response()->json(['message' => 'No Pessoa associated with this user'], 404);
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
