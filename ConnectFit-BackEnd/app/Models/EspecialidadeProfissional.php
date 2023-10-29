<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EspecialidadeProfissional extends Model
{
    use HasFactory;
    public function pessoaProfissional()
    {
        return $this->belongsTo(PessoaProfissional::class, 'idPessoaProfissional');
    }
    public function especialidade()
    {
        return $this->belongsTo(Especialidade::class, 'idEspecialidade');
    }
}
