<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Medida extends Model
{
    use HasFactory;
    public function pessoaUsuario()
    {
        return $this->belongsTo(PessoaUsuario::class, 'idPessoaUsuario');
    }
    public function composicaoCorporal()
    {
        return $this->hasMany(ComposicaoCorporal::class);
    }
    public function enderecos()
    {
        return $this->belongsToMany(Area::class, 'area_medida_corporais', 'idArea', 'idMedida');
    }
}
