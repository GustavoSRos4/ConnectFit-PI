<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AreaDesc extends Model
{
    use HasFactory;
    public function lado()
    {
        return $this->belongsTo(Lado::class, 'SiglaLado');
    }
    public function area()
    {
        return $this->hasMany(Area::class);
    }
}
