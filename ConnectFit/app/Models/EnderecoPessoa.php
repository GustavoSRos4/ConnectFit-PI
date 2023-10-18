<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EnderecoPessoa extends Model
{
    use HasFactory;
    public function endereco()
    {
        return $this->belongsTo(Endereco::class, 'idEndereco');
    }
    public function pessoa()
    {
        return $this->belongsTo(Pessoa::class, 'idPessoa');
    }
}
