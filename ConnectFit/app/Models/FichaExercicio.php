<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FichaExercicio extends Model
{
    use HasFactory;
    public function ficha()
    {
        return $this->belongsTo(Ficha::class, 'idFicha');
    }
    public function exercicio()
    {
        return $this->belongsTo(Exercicio::class, 'idExercicio');
    }
}
