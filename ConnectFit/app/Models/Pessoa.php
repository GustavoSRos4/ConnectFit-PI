<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Laravel\Passport\HasApiTokens;

class Pessoa extends Model
{
    use  HasApiTokens, Notifiable;
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    public function sexo()
    {
        return $this->belongsTo(Sexo::class, 'Sexo');
    }
    public function telefone()
    {
        return $this->hasMany(Telefone::class);
    }
    public function enderecoPessoa()
    {
        return $this->hasMany(EnderecoPessoa::class);
    }
    public function pessoaUsuario()
    {
        return $this->hasOne(PessoaUsuario::class);
    }
    public function pessoaProfissional()
    {
        return $this->hasOne(PessoaProfissional::class);
    }
}
