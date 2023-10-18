<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Area extends Model
{
    use HasFactory;
    public function lado()
    {
        return $this->belongsTo(Lado::class, 'SiglaLado');
    }
    public function areaMedidaCorporal()
    {
        return $this->hasMany(AreaMedidaCorporal::class);
    }
}
