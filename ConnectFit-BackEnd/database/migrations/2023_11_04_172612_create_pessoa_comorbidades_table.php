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
        Schema::create('pessoa_comorbidades', function (Blueprint $table) {
            $table->unsignedInteger("idPessoaUsuario");
            $table->unsignedInteger("idComorbidade");
            $table->timestamps();
            $table->foreign('idPessoaUsuario')->references('idPessoaUsuario')->on('pessoa_usuarios')->onDelete('cascade');
            $table->foreign('idComorbidade')->references('idComorbidade')->on('comorbidades')->onDelete('cascade');
            $table->primary(['idPessoaUsuario', 'idComorbidade']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pessoa_comorbidades');
    }
};
