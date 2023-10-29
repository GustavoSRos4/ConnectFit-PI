<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ficha extends Model
{
    use HasFactory;
    public function pessoaProfissional()
    {
        return $this->belongsTo(Pessoa::class, 'idPessoaProfissional');
    }
    public function pessoaUsuario()
    {
        return $this->belongsTo(Pessoa::class, 'idPessoaUsuario');
    }
    public function fichaExercicio()
    {
        return $this->hasMany(FichaExercicio::class);
    }
}
