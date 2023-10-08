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
        Schema::create('telefones', function (Blueprint $table) {
            $table->unsignedInteger('idPessoaTelefone');
            $table->tinyInteger('Sequencia');
            $table->tinyInteger('DDD');
            $table->integer('Numero');
            $table->timestamps();
            $table->primary(["idPessoaTelefone","Sequencia"]);
            $table->foreign('idPessoaTelefone')->references('idPessoa')->on('pessoas')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('telefones');
    }
};
