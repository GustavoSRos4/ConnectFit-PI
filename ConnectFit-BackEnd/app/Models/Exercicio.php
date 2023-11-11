<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Exercicio extends Model
{
    use HasFactory;
    public function treino()
    {
        return $this->belongsToMany(Treino::class, 'treino_exercicios', 'idExercicio', 'idTreino');
    }
    protected $primaryKey = 'idExercicio';
    public $incrementing = true;
    protected $keyType = 'integer';
}
