<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Area;
use App\Models\Medida;
use App\Models\AreaMedida;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class MedidasController extends Controller
{
    public function create(Request $request)
    {
        $userId = auth('api')->user()->id;

        DB::beginTransaction();

        try {
            $medida = new Medida();
            $medida->idPessoaUsuarioMedida = $userId;
            $medida->save();
            $idMedida = $medida->idMedida;
            $areas = json_decode($request->input('Areas'));
            if (!empty($areas) && is_array($areas)) {
                foreach ($areas as $areaData) {
                    $AreaMedida = new AreaMedida();
                    $AreaMedida->idMedida = $idMedida;
                    $AreaMedida->idArea = $areaData->idArea;
                    $AreaMedida->Medida = $areaData->medida;
                    $AreaMedida->save();
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
    public function showAreas()
    {
        $areas = Area::all();
        return response()->json(['Areas' => $areas], 200);
    }
}
