<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\PessoaUsuario;
use App\Models\Medida;
use App\Models\AreaMedidaCorporal;
use App\Models\Area;
use App\Models\ComposicaoCorporal;
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
            DB::commit();
            return response()->json(['message' => 'Cadastrado com sucesso'], 201);
        } catch (\Exception $e) {
            DB::rollback();
            Log::error($e);

            return response()->json(['message' => 'Falha no cadastro', 'error' => $e->getMessage()], 500);
        }
    }
}
