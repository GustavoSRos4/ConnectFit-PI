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
    public function especialidade()
    {
        return $this->belongsToMany(Pessoa::class, 'especialidade_profissionais', 'idPessoaProfissional', 'idEspecialidade');
    }
    public function contrato()
    {
        return $this->hasMany(Contrato::class);
    }
    public function Ficha()
    {
        return $this->hasMany(Ficha::class);
    }
    protected $table = 'pessoa_profissionais';
}
