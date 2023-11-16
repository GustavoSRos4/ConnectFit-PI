<template>
  <div class="q-pa-md">
    <q-table class="bg-dark" title="Alunos" :rows="filteredRows" :columns="columns" row-key="idPessoa" :filter="filter"
      grid hide-header>
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
            <q-item clickable @click="AlunoDetail(props.row)" class="row fit">
              <div class="col-2 flex-center q-pr-sm">
                <q-avatar rounded color="red" class="vertical-middle" text-color="white">
                  {{ getFirstLetter(props.row.User.name) }}
                </q-avatar>
              </div>
              <div flat bordered class="col">

                <div class="row flex">
                  <div class=" col-12 text-center text-h6 q-px-xs no-margin">
                    <div class="cut-text text-bold">{{ props.row.User.name }}</div>
                  </div>
                </div>

                <div class="row">

                  <div class="flex col-6 text-caption q-pa-xs">
                    <div>{{ calcIdade(props.row.Pessoa.dataNas) }} anos</div>
                  </div>

                  <div class="flex col-6 text-caption q-pa-xs">
                    <div class="cut-text">
                      {{ getObjetivo(props.row.PessoaUsuario.idObjetivo) || 'Objetivo não encontrado' }}
                    </div>
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
import { defineComponent, ref, computed, onMounted } from 'vue';
import { api } from 'src/boot/axios';
import { useRouter } from 'vue-router';

const columns = [
  {
    name: 'name',
    label: 'Nome',
    field: row => row.User.name,
    format: val => `${val}`,
    sortable: true
  },
  { name: 'Idade', label: 'Idade', field: 'idade', sortable: true },
  { name: 'Objetivo', label: 'Objetivo', field: 'objetivos' },
];

export default defineComponent({
  name: 'AlunosDashboard',
  setup() {
    const router = useRouter();
    const filter = ref('');
    const selected = ref([]);
    const rows = ref([])
    const objetivos = ref([]);

    const fetchAlunos = async (tentativas) => {
      if (tentativas === 0) {
        console.log("Número de tentativas esgotado. Desistindo...");
        return;
      }

      try {
        console.log(`Tentativa ${11 - tentativas}`);
        const res = await api.get('api/showDataAlunos');
        rows.value = [...res.data.Pessoas];
      } catch (err) {
        console.log(err);
        await new Promise(resolve => setTimeout(resolve, 1000));
        await fetchAlunos(tentativas - 1);
      }
    };

    const fetchObjetivos = async () => {
      try {
        const res = await api.get('api/anamneseData');
        objetivos.value = [...res.data.Objetivos];
      } catch (err) {
        return [];
      }
    };

    const getObjetivo = (idObj) => {
      try {
        const objetivoEncontrado = objetivos.value.find(obj => obj.idObjetivo === idObj);

        if (objetivoEncontrado) {
          return objetivoEncontrado.Descricao;
        } else {
          return '';
        }
      } catch (err) {
        console.error(err);
        return '';
      }
    };

    onMounted(async () => {
      await fetchAlunos(10);
      await fetchObjetivos();
    });

    const getColumnClass = (columnName) => {
      switch (columnName) {
        case 'Nome':
          return 'col-12';
        case 'Idade':
          return 'col-6';
        case 'Objetivo':
          return 'col-6';
        default:
          return '';
      }
    };

    const filteredRows = computed(() => {
      const lowerCaseFilter = filter.value.toLowerCase();
      return rows.value.filter(row => row.User.name.toLowerCase().includes(lowerCaseFilter));
    });

    const getFirstLetter = (name) => {
      return name.charAt(0).toUpperCase();
    };

    const calcIdade = (dataNascimento) => {
      const hoje = new Date();
      const dataNasc = new Date(dataNascimento);

      let idade = hoje.getFullYear() - dataNasc.getFullYear();

      if (
        hoje.getMonth() < dataNasc.getMonth() ||
        (hoje.getMonth() === dataNasc.getMonth() && hoje.getDate() < dataNasc.getDate())
      ) {
        idade--;
      }
      return idade;
    };

    const AlunoDetail = (row) => {
      router.push({ name: 'AlunoDetail', params: { id: row.Pessoa.idPessoa } });
      console.log(row.Pessoa.idPessoa);
    }

    return {
      AlunoDetail,
      filter,
      selected,
      columns,
      filteredRows,
      getFirstLetter,
      calcIdade,
      getObjetivo,
      getColumnClass,
    };
  },
});
</script>

<style scoped>
.cut-text {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>
