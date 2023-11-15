<template>
  <div class="q-pa-lg">
    <q-table flat bordered title="Meus Exercícios" :rows="filteredRows" :columns="columns" row-key="idExercicio"
      :filter="filter" :loading="loading">
      <!-- HEADER DA TABELA, NOME e EDITAR -->
      <template v-slot:header="props">
        <q-tr :props="props">
          <q-th v-for="col in props.cols" :key="col.name" :props="props">
            {{ col.label }}
          </q-th>
          <q-th auto-width>Modificar Exercício</q-th>
        </q-tr>
      </template>
      <!-- Barra de pesquisa -->
      <template v-slot:top-right>
        <q-btn icon-right="edit" @click="CriarExercicio" ripple rounded class="bg-primary q-mr-lg"
          label="Criar Exercício" />
        <q-input borderless dense debounce="300" v-model="filter" placeholder="Pesquisar">
          <template v-slot:append>
            <q-icon name="search" />
          </template>
        </q-input>
      </template>
      <!-- Body Da tabela(dados) -->
      <template v-slot:body="props">
        <q-tr :props="props">
          <q-td key="Nome" :props="props">
            {{ props.row.Nome }}
          </q-td>
          <!-- Btn de editar -->
          <q-td class="row justify-center">
            <q-btn size="md" color="primary" dense icon='edit'>
              <q-menu anchor="center middle" self="top middle">
                <q-item clickable>
                  <q-item-section @click="apagarExercicio(props.row)">
                    Apagar Exercicio
                  </q-item-section>
                </q-item>
                <q-item clickable>
                  <q-item-section @click="editarExercicio(props.row)">
                    Editar Exercicio
                  </q-item-section>
                </q-item>
              </q-menu>
            </q-btn>
          </q-td>
        </q-tr>
      </template>
      <!-- Tela Loading -->
      <template v-slot:loading>
        <q-inner-loading showing color="primary" />
      </template>
    </q-table>
  </div>
</template>

<script>
import { api } from 'src/boot/axios';
import { ref, computed, defineComponent, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const columns = [
  {
    name: 'Nome',
    required: true,
    label: 'Nome do Exercício',
    align: 'left',
    field: row => row.Nome,
    format: val => `${val}`,
    sortable: true
  },
];

export default defineComponent({
  name: 'ExerciciosDashboard',
  setup() {
    const loading = ref(false);
    const rows = ref([]);
    const filter = ref('');

    const router = useRouter();

    const CriarExercicio = () => {
      router.push({ name: 'ExercicioCreate' });
    };

    const fetchExercicios = async (tentativas) => {
      if (tentativas === 0) {
        console.log("Número de tentativas esgotado. Desistindo...");
        return;
      }

      try {
        console.log(`Tentativa ${11 - tentativas}`);
        const res = await api.get('api/showExercicio');
        rows.value = [...res.data.Exercicios];
      } catch (err) {
        console.log(err);
        await new Promise(resolve => setTimeout(resolve, 1000));
        await fetchExercicios(tentativas - 1);
      }
    };

    onMounted(async () => {
      loading.value = true;
      try {
        await fetchExercicios(10);
      } finally {
        loading.value = false;
      }
    });

    const apagarExercicio = (exercicio) => {
      console.log("Apagar exercício:", exercicio);
      // Lógica para apagar exercício
    };

    const editarExercicio = (exercicio) => {
      console.log("Editar exercício:", exercicio);
      // Lógica para editar exercício
    };

    const filteredRows = computed(() => {
      const lowerCaseFilter = filter.value.toLowerCase();
      return rows.value.filter(row => row.Nome.toLowerCase().includes(lowerCaseFilter));
    });

    return {
      loading,
      columns,
      rows,
      CriarExercicio,
      fetchExercicios,
      filteredRows,
      filter,
      apagarExercicio,
      editarExercicio,
      print,
    };
  },
});
</script>
