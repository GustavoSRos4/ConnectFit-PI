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
        Schema::create('area_descs', function (Blueprint $table) {
            $table->tinyIncrements('idDesc');
            $table->string('descricao', 50);
            $table->char('SiglaLado', 1)->nullable();
            $table->timestamps();

            $table->foreign('SiglaLado')->references('Sigla')->on('lados')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('area_descs');
    }
};
