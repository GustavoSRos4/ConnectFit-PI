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
        Schema::create('area_medida_corporais', function (Blueprint $table) {
            $table->unsignedTinyInteger('idArea');
            $table->unsignedInteger('idMedida');
            $table->timestamps();

            $table->foreign('idArea')->references('idArea')->on('areas')->onDelete('cascade');
            $table->foreign('idMedida')->references('idMedida')->on('medidas')->onDelete('cascade');
            $table->primary(['idArea','idMedida']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('area_medida_corporais');
    }
};
