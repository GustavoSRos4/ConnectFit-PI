<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PessoaProfissional extends Model
{
    use HasFactory;
    public function pessoa()
    {
        return $this->belongsTo(Pessoa::class, 'idPessoaProfissional');
    }
    public function especialidadeProfissional()
    {
        return $this->hasMany(EspecialidadeProfissional::class);
    }
    public function contrato()
    {
        return $this->hasMany(Contrato::class);
    }
    public function Ficha()
    {
        return $this->hasMany(Ficha::class);
    }
}
