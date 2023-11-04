<?php

namespace Database\Seeders;

use App\Models\Duracao;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DuracaoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $duracoes = [
            ['Descricao' => '1 mês'],
            ['Descricao' => '6 meses'],
            ['Descricao' => '12 meses'],

        ];

        foreach ($duracoes as $duracao) {
            Duracao::create($duracao);
        }
    }
}
