<template>
  <div class="q-pa-lg">
    <q-table flat bordered title="Meus Exercícios" :rows="rows" :columns="columns" row-key="name" binary-state-sort
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
        <q-btn icon-right="edit" ripple rounded class="bg-primary q-mr-lg" label="Criar Exercício" />
        <!-- <q-separator vertical spaced /> -->
        <q-input borderless dense debounce="300" v-model="filter" placeholder="Pesquisar">
          <template v-slot:append>
            <q-icon name="search" />
          </template>
        </q-input>
      </template>
      <!-- Body Da tabela(dados) -->
      <template v-slot:body="props">
        <q-tr :props="props">
          <q-td key="name" :props="props">
            {{ props.row.name }}
          </q-td>
          <!-- Btn de editar -->
          <q-td class="row justify-center">
            <q-btn size="md" color="primary" dense icon='edit'>
              <q-menu anchor="center middle" self="top middle">
                <q-item clickable @click="removeRow(props.row.id)">
                  <q-item-section>Apagar Exercicio</q-item-section>
                </q-item>
                <q-item clickable>
                  <q-item-section>Editar Exercicio</q-item-section>
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
import { ref, computed } from 'vue'

const columns = [
  {
    name: 'name',
    required: true,
    label: 'Nome do Exercício',
    align: 'left',
    field: row => row.name,
    format: val => `${val}`,
    sortable: true
  },
]

const Originalrows = [
  { id: 1, name: 'Flexão de braço' },
  { id: 2, name: 'Agachamento' },
  { id: 3, name: 'Abdominal' },
  { id: 4, name: 'Levantamento de peso' }
]

import { defineComponent } from 'vue';
export default defineComponent({
  name: 'ExerciciosDashboard',
  setup() {
    const loading = ref(false)
    const rows = ref([...Originalrows])

    const removeRow = (e) => {
      console.log(loading.value);
      loading.value = true; // Define loading como verdadeiro imediatamente
      setTimeout(() => {
        let index = 0;
        for (let i = 0; i < rows.value.length; i++) {
          if (rows.value[i].id == e) {
            index = i;
            break;
          }
        }
        rows.value = [...rows.value.slice(0, index), ...rows.value.slice(index + 1)];
        loading.value = false; // Define loading como falso após 500ms
      }, 500);
    };

    return {
      loading,
      filter: ref(''),
      columns,
      rows,
      removeRow,

    }
  },
})
</script>
