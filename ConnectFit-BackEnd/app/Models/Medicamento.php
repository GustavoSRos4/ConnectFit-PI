<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Medicamento extends Model
{
    use HasFactory;
    public function pessoaUsuario()
    {
        return $this->belongsToMany(PessoaUsuario::class, 'pessoa_medicamentos', 'idMedicamento', 'idPessoaUsuario');
    }
    protected $primaryKey = 'idMedicamento';
    public $incrementing = true;
    protected $keyType = 'integer';
}
