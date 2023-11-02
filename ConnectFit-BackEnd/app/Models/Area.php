<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Area extends Model
{
    use HasFactory;
    public function areaDesc()
    {
        return $this->belongsTo(AreaDesc::class, 'idDesc');
    }
    public function areaMedidaCorporal()
    {
        return $this->hasMany(AreaMedidaCorporal::class);
    }
}
