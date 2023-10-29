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
        Schema::create('contratos', function (Blueprint $table) {
            $table->unsignedInteger('idPessoaUsuario');
            $table->unsignedInteger('idPessoaProfissional');
            $table->date('dataInic');
            $table->date('dataFinal')->nullable();
            $table->decimal('valor',9,2);
            $table->timestamps();

            $table->foreign('idPessoaProfissional')->references('idPessoaProfissional')->on('pessoa_profissionais')->onDelete('cascade');
            $table->foreign('idPessoaUsuario')->references('idPessoaUsuario')->on('pessoa_usuarios')->onDelete('cascade');
            $table->primary(['idPessoaProfissional','idPessoaUsuario','dataInic']);

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('contratos');
    }
};
