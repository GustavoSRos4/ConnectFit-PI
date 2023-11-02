<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('pessoa_usuarios', function (Blueprint $table) {
            $table->unsignedInteger("idPessoaUsuario")->primary();
            $table->tinyInteger('Altura');
            $table->boolean('Fumante');
            $table->unsignedTinyInteger('idNivelAtiFis');
            $table->unsignedTinyInteger('idObjetivo');
            $table->unsignedTinyInteger('idConsumoAlc');
            $table->timestamps();

            $table->foreign('idPessoaUsuario')->references('idPessoa')->on('pessoas')->onDelete('cascade');
            $table->foreign('idNivelAtiFis')->references('idNivelAtiFis')->on('nivel_ati_fisicas')->onDelete('cascade');
            $table->foreign('idObjetivo')->references('idObjetivo')->on('objetivos')->onDelete('cascade');
            $table->foreign('idConsumoAlc')->references('idConsumoAlc')->on('consumo_alcs')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pessoa_usuarios');
    }
};
