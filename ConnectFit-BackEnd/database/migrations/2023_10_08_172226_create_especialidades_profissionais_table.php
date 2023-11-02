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
        Schema::create('especialidade_profissionais', function (Blueprint $table) {
            $table->unsignedInteger('idPessoaProfissional');
            $table->unsignedInteger('idEspecialidade');
            $table->timestamps();
            $table->foreign('idPessoaProfissional')->references('idPessoaProfissional')->on('pessoa_profissionais')->onDelete('cascade');
            $table->foreign('idEspecialidade')->references('idEspecialidade')->on('especialidades')->onDelete('cascade');
            $table->primary(['idPessoaProfissional','idEspecialidade']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('especialidade_profissionais');
    }
};
