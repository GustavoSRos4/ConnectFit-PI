<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('comorbidades', function (Blueprint $table) {
            $table->integerIncrements('idComorbidade');
            $table->unsignedInteger('idPessoaUsuario');
            $table->string('descricao', 50);
            $table->timestamps();
            $table->foreign('idPessoaUsuario')->references('idPessoaUsuario')->on('pessoa_usuarios')->onDelete('cascade');
        });
    }


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('comorbidades');
    }
};
