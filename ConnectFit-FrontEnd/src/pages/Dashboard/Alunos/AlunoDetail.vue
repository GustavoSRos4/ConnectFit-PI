<template>
  <div class="q-pa-md">
    <q-card class="q-pa-md">

      <div class="row">
        <div class="col-md-6 col-xs-12">
          <q-avatar rounded color="red" text-color="white">
            {{ getFirstLetter('Gustavo') }}
          </q-avatar>
          <span class="q-pl-sm text-h6">Gustavo Silvério Rosa</span>
        </div>

        <div class="col-md-6 col-xs-12 flex column flex-center">
          <span class="text-caption">Nivel Atividade Física</span>
          <span class="row q-pl-sm text-h6" :class="NivelAtvFisica(1)">Sedentário</span>
        </div>
      </div>
      <div class="row q-pt-lg">
        <div class="col-md-3 col-sm-6 col-xs-12 flex column flex-center">
          <span class="text-caption">Altura</span>
          <span class="row q-pl-sm text-h6">1,79</span>
        </div>
        <div class="col-md-3 col-sm-6 col-xs-12 flex column flex-center">
          <span class="text-caption">Peso</span>
          <span class="row q-pl-sm text-h6">86kg</span>
        </div>
        <div class="col-md-3 col-sm-6 col-xs-12 flex column flex-center">
          <span class="text-caption">Fumante</span>
          <span class="row q-pl-sm text-h6">Sim</span>
        </div>
        <div class="col-md-3 col-sm-6 col-xs-12 flex column flex-center">
          <span class="text-caption">Consumo Alcoólico</span>
          <span class="row q-pl-sm text-h6">Regular</span>
        </div>
      </div>
      <div class="row q-pt-lg">
        <div class="col-md-6 col-sm-12">
          <q-list bordered class="q-mx-xl">
            <q-expansion-item expand-separator label="Medicamentos">
              <q-separator />
              <q-card>
                <q-card-section>
                  Ibruprofeno
                </q-card-section>
                <q-card-section>
                  Ibruprofeno
                </q-card-section>
                <q-card-section>
                  Ibruprofeno
                </q-card-section>
              </q-card>
            </q-expansion-item>
          </q-list>
        </div>
        <div class="col-md-6 col-sm-12">
          <q-list bordered class="q-mx-xl">
            <q-expansion-item expand-separator label="Comorbidades">
              <q-separator />
              <q-card>
                <q-card-section>
                  Obesidade
                </q-card-section>
                <q-card-section>
                  Cartilagem baixa
                </q-card-section>
              </q-card>
            </q-expansion-item>
          </q-list>
        </div>
      </div>
      <div class="row q-pt-lg">
        <div class="col-12">
          <line-chart :chart-data="data" />
        </div>
      </div>
    </q-card>
  </div>
</template>

<script>
import { defineComponent } from 'vue';
import { ref, computed } from 'vue';
import { useRoute } from 'vue-router';
import lineChart from 'src/components/lineChart.vue';


const columns = [
  { name: 'Nome', label: 'Nome', field: 'nome', sortable: true },
  { name: 'Idade', label: 'Idade', field: 'idade', sortable: true },
  { name: 'Objetivo', label: 'Objetivo', field: 'objetivos' },
]

const rows = [
  { nome: 'Gustavo Silvério Rosa Rosa Rosa RosaRosa', idade: 25, objetivos: 'Emagrecer, manter forma' },
  { nome: 'Ana Ana Ana Ana Ana Ana', idade: 30, objetivos: 'Manter a forma' },
  { nome: 'Carlos Carlos Carlos Carlos', idade: 22, objetivos: 'Ganhar massa muscular' },
  { nome: 'Maria', idade: 28, objetivos: 'Melhorar a flexibilidade' },
  { nome: 'José', idade: 35, objetivos: 'Aumentar resistência cardiovascular' },
  { nome: 'Camila', idade: 27, objetivos: 'Praticar esportes' },
  { nome: 'Lucas', idade: 29, objetivos: 'Aprender yoga' },
  { nome: 'Fernanda', idade: 26, objetivos: 'Participar de competições de corrida' },
  { nome: 'Rafael', idade: 31, objetivos: 'Desenvolver força muscular' },
  { nome: 'Patrícia', idade: 33, objetivos: 'Alcançar equilíbrio mental' },
  // Adicione mais linhas conforme necessário
];


export default defineComponent({
  components: { lineChart },
  name: 'AlunoDetail',
  setup() {
    const route = useRoute();
    const clientId = route.params.id;

    const getFirstLetter = (name) => {
      return name.charAt(0).toUpperCase();
    };

    const NivelAtvFisica = (nivel) => {
      switch (nivel) {
        case 1:
          return "text-red-10";
          break;
        case 2:
          return "text-yellow-9";
          break;
        case 3:
          return "text-deep-orange-10";
          break;
        case 4:
          return "text-light-green-14";
          break;
        case 5:
          return "text-green-14";
          break;
      }

    }
    const data = {
      labels: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho'],
      datasets: [
        {
          label: 'Braço Esquerdo',
          backgroundColor: "#ff5722",
          data: [40, 39, 10, 40, 39, 80, 40]
        },
        {
          label: 'Braço Direito',
          backgroundColor: "#f2f",
          data: [41, 40, 11, 40, 38, 82, 40]
        }
      ]
    };

    return {
      clientId,
      getFirstLetter,
      NivelAtvFisica,
      data,
    };
  },
});
</script>
