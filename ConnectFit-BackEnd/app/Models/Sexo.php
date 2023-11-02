<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sexo extends Model
{
    use HasFactory;
    public function pessoa()
    {
        return $this->hasMany(Pessoa::class);
    }

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'Sigla';
    public $incrementing = false;
    protected $keyType = 'char';
}
