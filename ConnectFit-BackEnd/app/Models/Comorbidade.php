<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comorbidade extends Model
{
    use HasFactory;
    public function pessoaUsuario()
    {
        return $this->belongsToMany(PessoaUsuario::class, 'pessoa_medicamentos', 'idComorbidade', 'idPessoaUsuario');
    }
    protected $primaryKey = 'idComorbidade';
    public $incrementing = true;
    protected $keyType = 'integer';
}
