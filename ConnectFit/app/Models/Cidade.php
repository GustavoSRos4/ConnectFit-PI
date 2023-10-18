<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cidade extends Model
{
    use HasFactory;
    public function uf()
    {
        return $this->belongsTo(UF::class, 'SiglaUF');
    }
    public function endereco()
    {
        return $this->hasMany(Endereco::class);
    }
}
