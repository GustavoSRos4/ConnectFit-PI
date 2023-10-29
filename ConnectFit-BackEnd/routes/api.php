<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\ApiAuthController as AuthController;
use App\Http\Controllers\ArticleController as ArticleController;
use App\Http\Controllers\PessoaController as PessoaController;
use App\Http\Controllers\RegistroController as RegistroController;

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
});
