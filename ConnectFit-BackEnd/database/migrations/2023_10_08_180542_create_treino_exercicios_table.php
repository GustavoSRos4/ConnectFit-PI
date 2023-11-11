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
        Schema::create('treino_exercicios', function (Blueprint $table) {
            $table->unsignedInteger('idTreino');
            $table->unsignedInteger('idExercicio');
            $table->text('Descricao')->nullable();
            $table->tinyInteger('Repeticoes');
            $table->tinyInteger('Descanso');
            $table->tinyInteger('Carga')->nullable();
            $table->string('linkVideo', 300);
            $table->timestamps();

            $table->foreign('idTreino')->references('idTreino')->on('treinos')->onDelete('cascade');
            $table->foreign('idExercicio')->references('idExercicio')->on('exercicios')->onDelete('cascade');
            $table->primary(['idTreino', 'idExercicio']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('treino_exercicios');
    }
};
