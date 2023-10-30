<template>
  <div class="q-pa-lg">
    <q-table flat bordered title="Exercícios" :rows="rows" :columns="columns" row-key="name" binary-state-sort
      :filter="filter">
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
  { id: 4, name: 'Levantamento de peso' },
  { id: 5, name: 'Corrida' },
  { id: 6, name: 'Caminhada rápida' },
  { id: 7, name: 'Supino' },
  { id: 8, name: 'Remada' },
  { id: 9, name: 'Prancha abdominal' },
  { id: 10, name: 'Burpee' },
  { id: 11, name: 'Agachamento sumô' },
  { id: 12, name: 'Barra fixa' },
  { id: 13, name: 'Desenvolvimento' },
  { id: 14, name: 'Pular corda' },
  { id: 15, name: 'Bicicleta ergométrica' },
  { id: 16, name: 'Mergulho' },
  { id: 17, name: 'Afundo' },
  { id: 18, name: 'Rosca direta' },
  { id: 19, name: 'Remada baixa' },
  { id: 20, name: 'Elevação lateral' },
  { id: 21, name: 'Flexão de perna' },
  { id: 22, name: 'Prancha lateral' },
  { id: 23, name: 'Abdução de quadril' },
  { id: 24, name: 'Extensão de quadril' },
  { id: 25, name: 'Elevação de perna' },
  { id: 26, name: 'Flexão plantar' },
  { id: 27, name: 'Crucifixo' },
  { id: 28, name: 'Agachamento búlgaro' },
  { id: 29, name: 'Bíceps' },
  { id: 30, name: 'Tríceps' },
  { id: 31, name: 'Ombro' },
  { id: 32, name: 'Peito' },
  { id: 33, name: 'Costas' },
  { id: 34, name: 'Panturrilha' },
  { id: 35, name: 'Lombar' },
  { id: 36, name: 'Glúteos' },
  { id: 37, name: 'Quadríceps' },
  { id: 38, name: 'Isquiotibiais' },
  { id: 39, name: 'Flexibilidade' },
  { id: 40, name: 'Resistência' },
  { id: 41, name: 'Força' },
  { id: 42, name: 'Potência' },
  { id: 43, name: 'Equilíbrio' },
  { id: 44, name: 'Agilidade' },
  { id: 45, name: 'Velocidade' },
  { id: 46, name: 'Coordenação' },
  { id: 47, name: 'Estabilidade' },
  { id: 48, name: 'Mobilidade' },
  { id: 49, name: 'Flexão invertida' },
  { id: 50, name: 'Elevação de ombro' },
  { id: 51, name: 'Saltos' },
  { id: 52, name: 'Alongamento' },
  { id: 53, name: 'Flexão de tronco' },
  { id: 54, name: 'Flexão de quadril' },
  { id: 55, name: 'Flexão de antebraço' },
  { id: 56, name: 'Squat jump' },
  { id: 57, name: 'Abdominal cruzado' },
  { id: 58, name: 'Abdominal infra' },
  { id: 59, name: 'Abdominal oblíquo' },
  { id: 60, name: 'Adução de quadril' },
  { id: 61, name: 'Alongamento de costas' },
  { id: 62, name: 'Alongamento de perna' },
  { id: 63, name: 'Aquecimento' },
  { id: 64, name: 'Argolas' },
  { id: 65, name: 'Arremesso' },
  { id: 66, name: 'Arrastão' },
  { id: 67, name: 'Avanço' },
  { id: 68, name: 'Back flip' },
  { id: 69, name: 'Backhand' },
  { id: 70, name: 'Badminton' },
  { id: 71, name: 'Balé' },
  { id: 72, name: 'Barriga tanquinho' },
  { id: 73, name: 'Basquete' },
  { id: 74, name: 'Beisebol' },
  { id: 75, name: 'Bicicleta' },
  { id: 76, name: 'Boliche' },
  { id: 77, name: 'Boxe' },
  { id: 78, name: 'Break dance' },
  { id: 79, name: 'Cama elástica' },
  { id: 80, name: 'Caminhada' },
  { id: 81, name: 'Canivete' },
  { id: 82, name: 'Capoeira' },
  { id: 83, name: 'Ciclismo' },
  { id: 84, name: 'Corda' },
  { id: 85, name: 'Crossfit' },
  { id: 86, name: 'Dança' },
  { id: 87, name: 'Dardo' },
  { id: 88, name: 'Disc golf' },
  { id: 89, name: 'Esgrima' },
  { id: 90, name: 'Fisiculturismo' },
  { id: 91, name: 'Futebol' },
  { id: 92, name: 'Ginástica' },
  { id: 93, name: 'Golfe' },
  { id: 94, name: 'Handebol' },
  { id: 95, name: 'Hipismo' },
  { id: 96, name: 'Hóquei' },
  { id: 97, name: 'Ioga' },
  { id: 98, name: 'Karatê' },
  { id: 99, name: 'Kung fu' },
  { id: 100, name: 'Natação' }
]

import { defineComponent } from 'vue';
export default defineComponent({
  name: 'ExerciciosDashboard',
  setup() {
    const rows = ref([...Originalrows])

    const removeRow = (e) => {
      setTimeout(() => {
        let index = 0;
        for (let i = 0; i < rows.value.length; i++) {
          if (rows.value[i].id == e) {
            index = i;
            break;
          }
        }
        rows.value = [...rows.value.slice(0, index), ...rows.value.slice(index + 1)];
      }, 500);
    };

    return {
      filter: ref(''),
      columns,
      rows,
      removeRow,

    }
  },
})
</script>
