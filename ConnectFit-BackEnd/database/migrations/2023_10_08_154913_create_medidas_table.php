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
        Schema::create('medidas', function (Blueprint $table) {
            $table->integerIncrements('idMedida');
            $table->unsignedInteger('idPessoaUsuarioMedida');
            $table->timestamps();

            $table->foreign('idPessoaUsuarioMedida')->references('idPessoaUsuario')->on('pessoa_usuarios')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('medidas');
    }
};
