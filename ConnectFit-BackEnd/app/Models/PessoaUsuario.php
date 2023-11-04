<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PessoaUsuario extends Model
{
    use HasFactory;
    public function pessoa()
    {
        return $this->belongsTo(Pessoa::class, 'idPessoaUsuario');
    }
    public function consumoAlc()
    {
        return $this->belongsTo(ConsumoAlc::class, 'idConsumoAlc');
    }
    public function objetivo()
    {
        return $this->belongsTo(Objetivo::class, 'idObjetivo');
    }
    public function nivelAtiFis()
    {
        return $this->belongsTo(NivelAtiFisica::class, 'idNivelAtiFis');
    }
    public function fumante()
    {
        return $this->belongsTo(Fumante::class, 'fumante');
    }
    public function comorbidade()
    {
        return $this->belongsToMany(Comorbidade::class, 'pessoa_comorbidades', 'idPessoaUsuario', 'idComorbidade');
    }
    public function medicamento()
    {
        return $this->belongsToMany(Medicamento::class, 'pessoa_medicamentos', 'idPessoaUsuario', 'idMedicamento');
    }
    public function Ficha()
    {
        return $this->hasMany(Ficha::class);
    }
    public function Medida()
    {
        return $this->hasMany(Medida::class);
    }
    public function contrato()
    {
        return $this->hasMany(Contrato::class);
    }
}
