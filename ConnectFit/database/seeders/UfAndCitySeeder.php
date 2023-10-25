<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class UfAndCitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run()
    {
        $data = json_decode(file_get_contents('C:\wamp64\www\ConnectionFit-PI\ConnectFit\database\seeders\CidadesEstados.json'), true);

        foreach ($data['estados'] as $estado) {
            $estadoData = [
                'SiglaUF' => $estado['sigla'],
                'Descricao' => $estado['nome'],
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ];

            DB::table('ufs')->insert($estadoData);

            foreach ($estado['cidades'] as $cidade) {
                $cidadeData = [
                    'NomeCidade' => $cidade,
                    'SiglaUF' => $estado['sigla'],
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ];

                DB::table('cidades')->insert($cidadeData);
            }
        }
    }
}
