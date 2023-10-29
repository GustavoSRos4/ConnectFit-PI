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
        Schema::create('composicoes_corporais', function (Blueprint $table) {
            $table->unsignedInteger('idMedidaCompCorp');
            $table->tinyInteger('Subescapular');
            $table->tinyInteger('Triceps');
            $table->tinyInteger('Peitoral');
            $table->tinyInteger('AxilarMedia');
            $table->tinyInteger('SupraIliaca');
            $table->tinyInteger('Abdominal');
            $table->tinyInteger('FemuralMedia');
            $table->timestamps();

            $table->foreign('idMedidaCompCorp')->references('idMedida')->on('medidas')->onDelete('cascade');
            $table->primary("idMedidaCompCorp");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('composicoes_corporais');
    }
};
