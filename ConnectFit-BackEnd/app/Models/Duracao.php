<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Duracao extends Model
{
    use HasFactory;
    public function contrato()
    {
        return $this->hasMany(Contrato::class);
    }
}
