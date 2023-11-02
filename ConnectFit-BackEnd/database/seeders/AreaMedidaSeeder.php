<?php

namespace Database\Seeders;

use App\Models\AreaDesc;
use App\Models\Lado;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AreaMedidaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $areaDescs = [
            ['Descricao' => 'Ombros'],
            ['Descricao' => 'Tórax'],
            ['Descricao' => 'Abdômen'],
            ['Descricao' => 'Cintura'],
            ['Descricao' => 'Quadril'],
            ['Descricao' => 'Braço Esquerdo'],
            ['Descricao' => 'Braço Direito'],
            ['Descricao' => 'Coxa Esquerda'],
            ['Descricao' => 'Coxa Direita'],
            ['Descricao' => 'Perna Esquerda'],
            ['Descricao' => 'Perna Direita'],
        ];

        foreach ($areaDescs as $areaDesc) {
            AreaDesc::create($areaDesc);
        }
    }
}
