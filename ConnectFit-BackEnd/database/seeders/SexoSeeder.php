<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Sexo;

class SexoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $sexos = [
            ['sigla' => 'M', 'descricao' => 'Masculino'],
            ['sigla' => 'F', 'descricao' => 'Feminino'],
        ];

        foreach ($sexos as $sexo) {
            Sexo::create($sexo);
        }
    }

}
