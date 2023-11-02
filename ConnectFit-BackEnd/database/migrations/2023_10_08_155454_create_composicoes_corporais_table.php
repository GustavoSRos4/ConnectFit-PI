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
        Schema::create('composicao_corporals', function (Blueprint $table) {
            $table->unsignedInteger('idMedidaCompCorp')->nullable();
            $table->tinyInteger('Subescapular')->nullable();
            $table->tinyInteger('Triceps')->nullable();
            $table->tinyInteger('Peitoral')->nullable();
            $table->tinyInteger('AxilarMedia')->nullable();
            $table->tinyInteger('SupraIliaca')->nullable();
            $table->tinyInteger('Abdominal')->nullable();
            $table->tinyInteger('FemuralMedia')->nullable();
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
        Schema::dropIfExists('composicao_corporals');
    }
};
