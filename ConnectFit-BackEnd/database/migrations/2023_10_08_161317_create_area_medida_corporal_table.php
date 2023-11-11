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
        Schema::create('area_medidas', function (Blueprint $table) {
            $table->unsignedInteger('idMedida');
            $table->unsignedInteger('idArea');
            $table->smallInteger('Medida');
            $table->timestamps();

            $table->foreign('idArea')->references('idArea')->on('areas')->onDelete('cascade');
            $table->foreign('idMedida')->references('idMedida')->on('medidas')->onDelete('cascade');
            $table->primary(['idArea', 'idMedida']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('area_medidas');
    }
};
