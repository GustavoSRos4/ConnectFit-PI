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
        Schema::create('endereco_pessoas', function (Blueprint $table) {
            $table->unsignedInteger("idPessoa");
            $table->unsignedInteger("idEndereco");
            $table->timestamps();
            $table->primary(['idPessoa','idEndereco']);

            $table->foreign('idPessoa')->references('idPessoa')->on('pessoas')->onDelete('cascade');
            $table->foreign('idEndereco')->references('idEndereco')->on('enderecos')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('endereco_pessoas');
    }
};
