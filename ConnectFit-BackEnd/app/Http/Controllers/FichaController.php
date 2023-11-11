<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Exercicio;
use App\Models\Ficha;
use App\Models\FichaTreino;
use App\Models\Treino;
use App\Models\TreinoExercicio;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class FichaController extends Controller
{
    public function createFicha(Request $request)
    {
        $userId = (auth('api')->user()->id);
        $request->validate([
            'idPessoaUsuario' => 'required|integer',
        ]);

        try {
            DB::beginTransaction();

            $ficha = new Ficha();
            $ficha->idPessoaUsuario = $request->input('idPessoaUsuario');
            $ficha->idPessoaProfissional = $userId;
            $ficha->save();

            $treinos = json_decode($request->input('Treinos'));
            foreach ($treinos as $treinoData) {
                $treino = new Treino();
                $treino->Descricao = $treinoData->descricao;
                $treino->save();

                $treinoFicha = new FichaTreino();
                $treinoFicha->idTreino = $treino->idTreino;
                $treinoFicha->idFicha = $ficha->idFicha;
                $treinoFicha->save();

                foreach ($treinoData->ExerciciosTreino as $exercicioData) {
                    $exercicioTreino = new TreinoExercicio();
                    $exercicioTreino->idTreino = $treino->idTreino;
                    $exercicioTreino->idExercicio = $exercicioData->idExercicio;
                    $exercicioTreino->Descricao = $exercicioData->Descricao;
                    $exercicioTreino->Repeticoes = $exercicioData->Repeticoes;
                    $exercicioTreino->descanso = $exercicioData->descanso;
                    $exercicioTreino->carga = $exercicioData->carga;
                    $exercicioTreino->linkVideo = $exercicioData->linkvideo;
                    $exercicioTreino->save();
                }
            }

            DB::commit();

            return response()->json(['message' => 'Ficha criada com sucesso'], 201);
        } catch (\Exception $e) {

            DB::rollback();
            Log::error($e);

            return response()->json(['message' => 'Falha ao criar ficha'], 500);
        }
    }
    public function createExercicio(Request $request)
    {
        $request->validate([
            'Nome' => 'required|string|unique:exercicios',
            'Musculo' => 'required|string',
        ]);

        try {
            DB::beginTransaction();

            $exercicio = new Exercicio();
            $exercicio->Nome = $request->input('Nome');
            $exercicio->Musculo = $request->input('Musculo');
            $exercicio->save();
            DB::commit();

            return response()->json(['message' => 'Exercício criado com sucesso'], 201);
        } catch (\Exception $e) {

            DB::rollback();
            Log::error($e);

            return response()->json(['message' => 'Falha ao criar exercício'], 500);
        }
    }
    public function showExercicio()
    {
        $exercicios = Exercicio::orderBy('Musculo')->get();
        return response()->json(['Exercicios' => $exercicios], 200);
    }
    public function showFicha()
    {
        $userId = auth('api')->user()->id;
        $fichas = Ficha::where('idPessoaUsuario', $userId)->orderBy('created_at', 'desc')->get();

        if ($fichas->isNotEmpty()) {
            $resultFichas = [];

            foreach ($fichas as $ficha) {
                $treinosFicha = FichaTreino::where('idFicha', $ficha->idFicha)->get();
                $resultTreinos = [];

                foreach ($treinosFicha as $treinoFicha) {
                    $treino = Treino::where('idTreino', $treinoFicha->idTreino)->first(); // Assuming a treino is unique for an idTreino

                    $resultExercicios = [];
                    if ($treino) {
                        $exercicios = TreinoExercicio::where('idTreino', $treino->idTreino)->get();

                        foreach ($exercicios as $exercicio) {
                            $resultExercicios[] = [
                                'idExercicio' => $exercicio->idExercicio,
                                'Descricao' => $exercicio->Descricao,
                                'Repeticoes' => $exercicio->Repeticoes,
                                'descanso' => $exercicio->descanso,
                                'carga' => $exercicio->carga,
                                'linkvideo' => $exercicio->linkvideo,
                            ];
                        }
                    }

                    $resultTreinos[] = [
                        'Treino' => $treino,
                        'Exercicios' => $resultExercicios,
                    ];
                }

                $resultFichas[] = [
                    'Ficha' => $ficha,
                    'Treinos' => $resultTreinos,
                ];
            }

            return response()->json(['Fichas' => $resultFichas], 200);
        }
    }
}
