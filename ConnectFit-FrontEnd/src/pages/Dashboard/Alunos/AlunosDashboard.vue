<template>
  <div class="q-pa-md">
    <q-table class="bg-dark" title="Alunos" :rows="filteredRows" :columns="columns" row-key="name" :filter="filter" grid
      hide-header>
      <template v-slot:top-right>
        <q-input borderless dense debounce="300" v-model="filter" placeholder="Pesquisar">
          <template v-slot:append>
            <q-icon name="search" />
          </template>
        </q-input>
      </template>

      <template v-slot:item="props">
        <div class="q-pa-xs col-xs-12 col-sm-6 col-md-4 col-lg-3 grid-style-transition">
          <q-card flat>
            <q-item clickable class="row fit">
              <div class="col-2 flex-center q-pr-sm">
                <q-avatar rounded color="red" class="vertical-middle" text-color="white">
                  {{ getFirstLetter(props.row.nome) }}
                </q-avatar>
              </div>
              <div flat bordered class="col">

                <div class="row flex">
                  <div class=" col-12 text-center text-h6 q-px-xs no-margin">
                    <div class="cut-text text-bold">{{ props.row.nome }}</div>
                  </div>
                </div>

                <div class="row">

                  <div class="flex col-6 text-caption q-pa-xs">
                    <div>{{ props.row.idade }} anos</div>
                  </div>

                  <div class="flex col-6 text-caption q-pa-xs">
                    <div class="cut-text">{{ props.row.objetivos }}</div>
                  </div>

                </div>
              </div>
            </q-item>
          </q-card>
        </div>
      </template>
    </q-table>
  </div>
</template>

<script>
import { defineComponent } from 'vue';
import { ref, computed } from 'vue';

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
  name: 'AlunosDashboard',
  setup() {
    const filter = ref('');
    const selected = ref([]);

    const getColumnClass = (columnName) => {
      switch (columnName) {
        case 'Nome':
          return 'col-12'; // Substitua 'nome-class' pelo nome da classe desejada para a coluna 'Nome'
        case 'Idade':
          return 'col-6'; // Substitua 'idade-class' pelo nome da classe desejada para a coluna 'Idade'
        case 'Objetivo':
          return 'col-6'; // Substitua 'objetivo-class' pelo nome da classe desejada para a coluna 'Objetivo'
        default:
          return '';
      }
    };

    // Filtro para exibir apenas as linhas que correspondem ao filtro
    const filteredRows = computed(() => {
      const lowerCaseFilter = filter.value.toLowerCase();
      return rows.filter(row => row.nome.toLowerCase().includes(lowerCaseFilter));
    });

    const getFirstLetter = (name) => {
      return name.charAt(0).toUpperCase();
    };

    return {
      filter,
      selected,
      columns,
      filteredRows,
      getFirstLetter,
      getColumnClass,
    };
  },
});
</script>
<style scoped>
/* Adicione uma classe para cortar o texto */
.cut-text {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>
