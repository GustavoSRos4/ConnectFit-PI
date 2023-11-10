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
        Schema::create('ficha_treinos', function (Blueprint $table) {
            $table->unsignedInteger('idFicha');
            $table->unsignedInteger('idTreino');
            $table->timestamps();
            $table->foreign('idTreino')->references('idTreino')->on('treinos')->onDelete('cascade');
            $table->foreign('idFicha')->references('idFicha')->on('fichas')->onDelete('cascade');
            $table->primary(['idTreino', 'idFicha']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ficha_treinos');
    }
};
