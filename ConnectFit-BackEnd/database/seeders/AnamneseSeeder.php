<?php

namespace Database\Seeders;

use App\Models\ConsumoAlc;
use App\Models\Objetivo;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AnamneseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $consumos = [
            ['Descricao' => 'Nenhum'],
            ['Descricao' => 'Socialmente'],
            ['Descricao' => 'Moderado'],
            ['Descricao' => 'Regular'],
        ];

        foreach ($consumos as $consumo) {
            ConsumoAlc::create($consumo);
        }
        $objetivos = [
            ['Descricao' => 'Perda de peso'],
            ['Descricao' => 'Ganho de massa muscular'],
            ['Descricao' => 'Aumento da força'],
            ['Descricao' => 'Melhoria da postura'],
            ['Descricao' => 'Definição muscular'],
        ];

        foreach ($objetivos as $objetivo) {
            Objetivo::create($objetivo);
        }
        $niveisAtiFis = [
            ['Descricao' => 'Sedentário'],
            ['Descricao' => 'Levemente ativo'],
            ['Descricao' => 'Moderadamente ativo'],
            ['Descricao' => 'Ativo'],
            ['Descricao' => 'Atleta'],
        ];

        foreach ($niveisAtiFis as $nivelAtiFis) {
            Objetivo::create($nivelAtiFis);
        }
    }
}
