<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Contrato extends Model
{
    public function pessoaProfissional()
    {
        return $this->belongsTo(PessoaProfissional::class, 'idPessoaProfissional');
    }
    public function pessoaUsuario()
    {
        return $this->belongsTo(PessoaUsuario::class, 'idPessoaUsuario');
    }
}
