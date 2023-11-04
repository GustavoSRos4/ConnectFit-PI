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
        Schema::create('pessoa_medicamentos', function (Blueprint $table) {
            $table->unsignedInteger("idPessoaUsuario");
            $table->unsignedInteger("idMedicamento");
            $table->timestamps();
            $table->foreign('idPessoaUsuario')->references('idPessoaUsuario')->on('pessoa_usuarios')->onDelete('cascade');
            $table->foreign('idMedicamento')->references('idMedicamento')->on('medicamentos')->onDelete('cascade');
            $table->primary(['idPessoaUsuario', 'idMedicamento']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pessoa_medicamentos');
    }
};
