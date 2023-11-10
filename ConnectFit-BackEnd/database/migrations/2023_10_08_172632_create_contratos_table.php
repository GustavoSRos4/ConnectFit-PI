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
            $table->dateTime('dataInic')->nullable();
            $table->dateTime('dataFinal')->nullable();
            $table->tinyInteger("idDuracao");
            $table->decimal('valor',9,2);
            $table->timestamps();

            $table->foreign('idPessoaProfissional')->references('idPessoaProfissional')->on('pessoa_profissionais')->onDelete('cascade');
            $table->foreign('idPessoaUsuario')->references('idPessoaUsuario')->on('pessoa_usuarios')->onDelete('cascade');
            $table->primary(['idPessoaProfissional','idPessoaUsuario','created_at']);

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
