<?php

namespace Database\Seeders;

use App\Models\Area;
use Illuminate\Database\Seeder;

class AreaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $areas = [
            #BF '%'
            ['Descricao' => 'Gordura Corporal'],
            #PESO 'kg'
            ['Descricao' => 'Peso'],
            #Medidas Fita 'CM'
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
            #Dobras "mm"
            ['Descricao' => 'Subescapular'],
            ['Descricao' => 'Triceps'],
            ['Descricao' => 'Peitoral'],
            ['Descricao' => 'AxilarMedia'],
            ['Descricao' => 'SupraIliaca'],
            ['Descricao' => 'Abdominal'],
            ['Descricao' => 'FemuralMedia'],


        ];

        foreach ($areas as $area) {
            Area::create($area);
        }
    }
}
