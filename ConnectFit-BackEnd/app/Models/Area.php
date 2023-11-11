<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Area extends Model
{
    use HasFactory;
    public function medidas()
    {
        return $this->belongsToMany(Medida::class, 'area_medidas', 'idArea', 'idMedida');
    }
    protected $primaryKey = 'idArea';
    public $incrementing = true;
    protected $keyType = 'integer';
}
