<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AreaMedidaCorporal extends Model
{
    use HasFactory;
    public function area()
    {
        return $this->belongsTo(Area::class, 'idArea');
    }
    public function medida()
    {
        return $this->belongsTo(Medida::class, 'idMedida');
    }
}
