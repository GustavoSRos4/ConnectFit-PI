<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Treino extends Model
{
    use HasFactory;
    public function ficha()
    {
        return $this->belongsToMany(Ficha::class, 'ficha_treinos', 'idTreino', 'idFicha');
    }
    public function exercicio()
    {
        return $this->belongsToMany(Exercicio::class, 'treino_exercicios', 'idTreino', 'idExercicio');
    }
}
