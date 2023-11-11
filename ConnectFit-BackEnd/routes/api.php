<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\ApiAuthController as AuthController;
use App\Http\Controllers\ContratoController;
use App\Http\Controllers\FichaController;
use App\Http\Controllers\PessoaController as PessoaController;
use App\Http\Controllers\PessoaUsuarioController;
use App\Http\Controllers\RegistroController as RegistroController;
use App\http\Controllers\MedidasController as MedidasController;
use App\Http\Controllers\PessoaProfissionalController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware(['cors', 'json.response', 'auth:api'])->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['middleware' => ['cors', 'json.response']], function () {
    //Teste
    // ...

    // public routes
    Route::post('/login', [AuthController::class, 'login']);
    Route::post('/registrarUsuario', [AuthController::class, 'register']);


    // ...

});

Route::middleware(['cors', 'json.response', 'auth:api'])->group(function () {
    // our routes to be protected will go in her
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/mostrarPessoa', [PessoaController::class, 'show']);
    Route::get('/ufSexo', [RegistroController::class, 'ufSexo']);
    Route::get('/{uf}/cidades', [RegistroController::class, 'cidades']);
    Route::post('/criarPessoa', [RegistroController::class, 'create']);
    Route::post('/createPessoaUsuario', [PessoaUsuarioController::class, 'create']);
    Route::post('/createMedida', [MedidasController::class, 'create']);
    Route::get('/showAreas', [MedidasController::class, 'showAreas']);
    Route::post('/createPessoaProfissional', [PessoaProfissionalController::class, 'create']);
    Route::post('/createContrato', [ContratoController::class, 'create']);
    Route::get('/anamneseData', [PessoaUsuarioController::class, 'anamneseData']);
    Route::get('/mostrarPessoaUsuario', [PessoaUsuarioController::class, 'showDataPessoaUsuario']);
    Route::get('/mostrarPessoaProfissional', [PessoaProfissionalController::class, 'showDataPessoaProfissional']);
    Route::get('/mostrarContratos', [ContratoController::class, 'show']);
    Route::get('/duracao', [ContratoController::class, 'showDuracao']);
    Route::post('/createFicha', [FichaController::class, 'createFicha']);
    Route::post('/createExercicio', [FichaController::class, 'createExercicio']);
    Route::get('/showExercicio', [FichaController::class, 'showExercicio']);
    Route::get('/showFicha', [FichaController::class, 'showFicha']);
});
