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
        Schema::create('areas', function (Blueprint $table) {
            $table->tinyIncrements('idArea');
            $table->string("Descricao",50);
            $table->smallInteger('Medida');
            $table->char('SiglaLado',1);
            $table->timestamps();

            $table->foreign('SiglaLado')->references('Sigla')->on('lados')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('areas');
    }
};
