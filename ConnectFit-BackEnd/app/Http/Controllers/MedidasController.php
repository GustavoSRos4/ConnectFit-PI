<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Area;
use App\Models\Medida;
use App\Models\AreaMedida;
use App\Models\Pessoa;
use DateTime;
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
            $areasComValores = array_filter($areas, function ($areaData) {
                return ($areaData->idArea >= 14 && $areaData->idArea <= 20 && isset($areaData->medida));
            });
            if (!empty($areasComValores) && count($areasComValores) === 7) {
                $percentualGordura = $this->calcularPercentualGordura($areasComValores, $userId);
                $area1 = new AreaMedida();
                $area1->idMedida = $idMedida;
                $area1->idArea = 1;
                $area1->Medida = $percentualGordura;
                $area1->save();
            }
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
    function calcularPercentualGordura($areas, $userId)
    {
        $pessoa = Pessoa::where('idPessoa', $userId)->first();
        $sexo = $pessoa->SiglaSexo;
        $dataNas = $pessoa->dataNas;
        $dataNascimento = new DateTime($dataNas);
        $dataAtual = new DateTime();
        $diferenca = $dataNascimento->diff($dataAtual);
        $idade = $diferenca->y;
        $somaDobras = 0;
        foreach ($areas as $area) {
            $somaDobras += $area->medida;
        }
        $densidadeCorporal = 0;
        if ($sexo == 'M') {
            $densidadeCorporal = 1.112 - 0.00043499 * $somaDobras + 0.00000055 * pow($somaDobras, 2) - 0.00028826 * $idade;
        } else {
            $densidadeCorporal = 1.097  - 0.00046971 * $somaDobras + 0.00000056 * pow($somaDobras, 2) - 0.00012828 * $idade;
        }
        $percentualGordura = ((4.95 / $densidadeCorporal) - 4.50) * 100;
        return $percentualGordura;
    }
    public function showAreas()
    {
        $areas = Area::all();
        return response()->json(['Areas' => $areas], 200);
    }
}
