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
        Schema::create('medicamentos', function (Blueprint $table) {
            $table->integerIncrements('idMedicamento');
            $table->unsignedInteger('idPessoaUsuario');
            $table->string('descricao', 60);
            $table->timestamps();
            $table->foreign('idPessoaUsuario')->references('idPessoaUsuario')->on('pessoa_usuarios')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('medicamentos');
    }
};
