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
        Schema::create('pessoa_profissionais', function (Blueprint $table) {
            $table->unsignedInteger('idPessoaProfissional');
            $table->string('numReg', 50)->nullable();
            $table->date('dataFormacao')->nullable();
            $table->decimal('valor', 9, 2);
            $table->integer('ativo', 1);
            $table->timestamps();

            $table->foreign('idPessoaProfissional')->references('idPessoa')->on('pessoas')->onDelete('cascade');
            $table->primary('idPessoaProfissional');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pessoa_profissionais');
    }
};
