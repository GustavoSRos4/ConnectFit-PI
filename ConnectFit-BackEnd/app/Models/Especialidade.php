<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Especialidade extends Model
{
    use HasFactory;
    public function pessoas()
    {
        return $this->belongsToMany(Pessoa::class, 'especialidade_profissionais', 'idEspecialidade', 'idPessoaProfissional');
    }
    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'idEspecialidade';
    public $incrementing = true;
    protected $keyType = 'integer';
}
