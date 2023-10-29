<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComposicaoCorporal extends Model
{
    use HasFactory;
    public function medida()
    {
        return $this->belongsTo(Medida::class, 'idMedidaCompCorp');
    }
}
