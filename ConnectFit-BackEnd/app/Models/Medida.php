<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Medida extends Model
{
    use HasFactory;
    public function pessoaUsuario()
    {
        return $this->belongsTo(PessoaUsuario::class, 'idPessoaUsuario');
    }

    public function area()
    {
        return $this->belongsToMany(Area::class, 'area_medidas', 'idArea', 'idMedida');
    }
                /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'idMedida';
    public $incrementing = true;
    protected $keyType = 'integer';
}
