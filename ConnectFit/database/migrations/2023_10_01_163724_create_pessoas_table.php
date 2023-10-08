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
        Schema::create('pessoas', function (Blueprint $table) {
            $table->unsignedInteger('idPessoa')->primary();
            $table->bigInteger('cpf');
            $table->text('descricao')->nullable();
            $table->date('dataNas');
            $table->string('SiglaSexo',1);
            $table->timestamps();
            $table->foreign('idPessoa')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('SiglaSexo')->references('Sigla')->on('sexos')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pessoas');
    }
};
