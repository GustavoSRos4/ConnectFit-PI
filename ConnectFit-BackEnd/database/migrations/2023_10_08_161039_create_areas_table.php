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
            $table->smallInteger('Medida');
            $table->unsignedTinyInteger('idDesc');
            $table->timestamps();

            $table->foreign('idDesc')->references('idDesc')->on('area_descs')->onDelete('cascade');
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
