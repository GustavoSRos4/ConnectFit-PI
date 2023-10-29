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
        Schema::create('enderecos', function (Blueprint $table) {
            $table->integerIncrements("idEndereco");
            $table->unsignedInteger("idCidade");
            $table->string("Logradouro",50);
            $table->smallInteger("Numero");
            $table->string("Complemento",15)->nullable();
            $table->integer("CEP");
            $table->string("Bairro",50);
            $table->timestamps();
            $table->unique(['Logradouro', 'Numero', 'Complemento','Bairro','CEP']);
            $table->foreign('idCidade')->references('idCidade')->on('cidades')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('enderecos');
    }
};
