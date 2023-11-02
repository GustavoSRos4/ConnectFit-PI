<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class ResetPasswordController extends Controller
{
    protected function resetPassword($user, $password)
    {
        $user->password = Hash::make($password);
        $user->save();
        event(new PasswordReset($user));
    }
    protected function sendResetResponse(Request $request, $response)
    {
        $response = ['message' => "Senha recuperada com sucesso!"];
        return response($response, 200);
    }
    protected function sendResetFailedResponse(Request $request, $response)
    {
        $response = "Token inválido";
        return response($response, 401);
    }
}
