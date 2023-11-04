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

class MedidasController extends Controller
{
    public function create(Request $request)
    {
        $userId = auth('api')->user()->id;

        $request->validate([
            'peso' => 'required|integer',
            'percentualGordura' => 'nullable|integer',
            'descricaoMed' => 'nullable|string|max:60',
            'descricaoComor' => 'nullable|string|max:50',
            'subescapular' => 'nullable',
            'triceps' => 'nullable',
            'peitoral' => 'nullable',
            'axilarMedia' => 'nullable',
            'supraIliaca' => 'nullable',
            'abdominal' => 'nullable',
            'femuralMedia' => 'nullable',
            'Areas' => 'nullable',
        ]);

        DB::beginTransaction();

        try {
            $medida = new Medida();
            $medida->idPessoaUsuarioMedida = $userId;
            $medida->peso = $request->input('peso');
            $medida->percentualGordura = $request->input('percentualGordura');
            $medida->save();
            $idMedida = $medida->idMedida;

            $composicaoCorp = new ComposicaoCorporal();
            $composicaoCorp->idMedidaCompCorp = $idMedida;
            $composicaoCorp->subescapular = $request->input('subescapular');
            $composicaoCorp->triceps = $request->input('triceps');
            $composicaoCorp->peitoral = $request->input('peitoral');
            $composicaoCorp->axilarMedia = $request->input('axilarMedia');
            $composicaoCorp->supraIliaca = $request->input('supraIliaca');
            $composicaoCorp->abdominal = $request->input('abdominal');
            $composicaoCorp->femuralMedia = $request->input('femuralMedia');
            $composicaoCorp->save();


            $areas = json_decode($request->input('Areas'));
            if (!empty($areas) && is_array($areas)) {
                foreach ($areas as $areaData) {
                    $area = new Area();
                    $area->Medida = $areaData->Medida;
                    $area->idDesc = $areaData->idDesc;
                    $area->save();

                    $idArea = $area->idArea;

                    $areaMedCorp = new AreaMedidaCorporal();
                    $areaMedCorp->idArea = $idArea;
                    $areaMedCorp->idMedida = $idMedida;
                    $areaMedCorp->save();
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
