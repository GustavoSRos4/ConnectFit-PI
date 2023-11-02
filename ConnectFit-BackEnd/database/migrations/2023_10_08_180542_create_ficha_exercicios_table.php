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
        Schema::create('ficha_exercicios', function (Blueprint $table) {
            $table->unsignedInteger('idFicha');
            $table->unsignedSmallInteger('idExercicio');
            $table->text('Descricao')->nullable();
            $table->tinyInteger('Repeticoes');
            $table->tinyInteger('Descanso');
            $table->tinyInteger('Carga');
            $table->string('linkVideo', 150);
            $table->timestamps();

            $table->foreign('idFicha')->references('idFicha')->on('fichas')->onDelete('cascade');
            $table->foreign('idExercicio')->references('idExercicio')->on('exercicios')->onDelete('cascade');
            $table->primary(['idFicha', 'idExercicio']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ficha_exercicios');
    }
};
