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
        Schema::create('fichas', function (Blueprint $table) {
            $table->integerIncrements('idFicha');
            $table->unsignedInteger('idPessoaUsuario');
            $table->unsignedInteger('idPessoaProfissional');
            $table->date('dataFim')->nullable();
            $table->timestamps();

            $table->foreign('idPessoaUsuario')->references('idPessoaUsuario')->on('pessoa_usuarios')->onDelete('cascade');
            $table->foreign('idPessoaProfissional')->references('idPessoaProfissional')->on('pessoa_profissionais')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('fichas');
    }
};
