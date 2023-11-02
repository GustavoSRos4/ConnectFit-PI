<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Telefone extends Model
{
    use HasFactory;
    public function pessoa()
    {
        return $this->belongsTo(Pessoa::class, 'idPessoaTelefone');
    }
        /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'idPessoaTelefone';
    public $incrementing = false;
    protected $keyType = 'integer';
}
