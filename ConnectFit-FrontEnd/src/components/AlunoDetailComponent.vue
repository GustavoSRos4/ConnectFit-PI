<template>
  <div class="q-pa-md">
    <q-card class="q-pa-md">
      <div class="row">
        <div class="col-md-6 col-xs-12">
          <q-avatar rounded color="red" text-color="white">
            {{ getFirstLetter('gustavo') }}
          </q-avatar>
          <span class="q-pl-sm text-h6">{{ nome() }}</span>
        </div>

        <div class="col-md-6 col-xs-12 flex column flex-center">
          <span class="text-caption">Nível Atividade Física</span>
          <span class="row q-pl-sm text-h6" :class="NivelAtvFisica(idNivelAtiFis())">{{
            getAtividadeFisica(idNivelAtiFis()) }}</span>
        </div>
      </div>
      <div class="row q-pt-lg">
        <div class="col-md-3 col-sm-6 col-xs-12 flex column flex-center">
          <span class="text-caption">Altura</span>
          <span class="row q-pl-sm text-h6">{{ altura() }}</span>
        </div>
        <div class="col-md-3 col-sm-6 col-xs-12 flex column flex-center">
          <span class="text-caption">Peso</span>
          <span class="row q-pl-sm text-h6">86kg</span>
        </div>
        <div class="col-md-3 col-sm-6 col-xs-12 flex column flex-center">
          <span class="text-caption">Fumante</span>
          <span class="row q-pl-sm text-h6">{{ getFumante() }}</span>
        </div>
        <div class="col-md-3 col-sm-6 col-xs-12 flex column flex-center">
          <span class="text-caption">Consumo Alcoólico</span>
          <span class="row q-pl-sm text-h6">{{ getConsumoAlc() }}</span>
        </div>
      </div>
      <div class="row q-pt-lg">
        <div class="col-md-6 col-sm-12">
          <q-list bordered class="q-mx-xl">
            <q-expansion-item expand-separator label="Medicamentos">
              <q-separator />
              <q-card>
                <q-card-section v-for="value in getMedicamentos()" :key="value.idMedicamento">
                  {{ value.descricao }}
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
                <q-card-section v-for="value in getComorbidades()" :key="value.idComorbidade">
                  {{ value.descricao }}
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
    <q-btn>asdasdasdas</q-btn>
  </div>
</template>

<script>
import { ref, defineComponent, onMounted, toRefs } from 'vue';
import { useRoute } from 'vue-router';
import lineChart from 'src/components/lineChart.vue';
import { api } from 'src/boot/axios';


export default defineComponent({
  components: { lineChart },
  name: 'AlunoDetailComponent',
  setup() {
    const aluno = ref({});
    const route = useRoute();
    const clientId = route.params.id;
    const anamnese = ref([{ nvAtvFisica: {} }, { Fumante: {} }, { ConsumoAlc: {} }, { Objetivos: {} }]);
    const Medicamentos = ref();
    const Comorbidades = ref();

    const getFirstLetter = (name) => {
      return name.charAt(0).toUpperCase();
    };

    const NivelAtvFisica = (nivel) => {
      switch (nivel) {
        case 1:
          return "text-red-10";
        case 2:
          return "text-yellow-9";
        case 3:
          return "text-deep-orange-10";
        case 4:
          return "text-light-green-14";
        case 5:
          return "text-green-14";
      }
    };

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

    const fetchAluno = async (tentativas) => {
      if (tentativas === 0) {
        console.log("Número de tentativas esgotado. Desistindo...");
        return;
      }

      try {
        console.log(`Tentativa ${11 - tentativas} Aluno.`);
        const res = await api.get(`api/showDataAluno/${route.params.id}`);
        aluno.value = { ...res.data };
        console.log(aluno.value);
        Medicamentos.value = aluno.value.Medicamentos
        Comorbidades.value = aluno.value.Comorbidades
      } catch (err) {
        console.log(err);
        await new Promise(resolve => setTimeout(resolve, 1000));
        await fetchAluno(tentativas - 1);
      }
    };


    const fetchAnam = async (tentativas) => {
      if (tentativas === 0) {
        console.log("Número de tentativas esgotado (Anamnese). Desistindo...");
        return;
      }

      try {
        console.log(`Tentativa ${11 - tentativas} Anamnese.`);
        const res = await api.get('api/anamneseData');
        anamnese.value = [res.data];
        anamnese.value.nvAtvFisica = [res.data.nivelAtiFis];
        anamnese.value.Fumante = [res.data.Fumante];
        anamnese.value.ConsumoAlc = [res.data.ConsumoAlc];
        anamnese.value.Objetivos = [res.data.Objetivos];
      } catch (err) {
        console.log(err);
        await new Promise(resolve => setTimeout(resolve, 1000));
        await fetchAluno(tentativas - 1);
      }
    };

    onMounted(async () => {
      await fetchAluno(10);
      await fetchAnam(10);
    });

    const nome = () => {
      //Verifica se no render ele carregou, entao envia para o template! (nao consegui fazer funcionar de outra maneira)
      return aluno.value.User ? aluno.value.User.name : '';
    }
    const altura = () => {
      const alturaValue = aluno.value.User ? aluno.value.PessoaUsuario.Altura : '';
      const alturaNumerica = parseFloat(alturaValue) / 100;
      return isNaN(alturaNumerica) ? '' : alturaNumerica.toFixed(2);
    }


    const idNivelAtiFis = () => {
      return aluno.value.PessoaUsuario ? aluno.value.PessoaUsuario.idNivelAtiFis : '';
    }

    const getFumante = () => {
      try {
        const idA = aluno.value.PessoaUsuario.idFumante;
        if (anamnese.value && anamnese.value.Fumante) {

          const Encontrado = anamnese.value.Fumante[0].find(obj => obj.idFumante === idA);

          if (Encontrado) {
            return Encontrado.Descricao;
          } else {
            return '';
          }
        } else {
          return '';
        }
      } catch (err) {
        console.error(err);
        return '';
      }
    }
    const getAtividadeFisica = (idA) => {
      try {
        if (anamnese.value && anamnese.value.nvAtvFisica) {

          const Encontrado = anamnese.value.nvAtvFisica[0].find(obj => obj.idNivelAtiFis === idA);

          if (Encontrado) {
            return Encontrado.Descricao;
          } else {
            return '';
          }
        } else {
          return '';
        }
      } catch (err) {
        console.error(err);
        return '';
      }
    }

    const getConsumoAlc = () => {
      try {
        const idA = aluno.value.PessoaUsuario.idConsumoAlc; //Pega o idConsumo do Usuario
        if (anamnese.value && anamnese.value.nvAtvFisica) {

          const Encontrado = anamnese.value.ConsumoAlc[0].find(obj => obj.idConsumoAlc === idA);

          if (Encontrado) {
            return Encontrado.Descricao;
          } else {
            return '';
          }
        } else {
          return '';
        }
      } catch (err) {
        console.error(err);
        return '';
      }
    }

    const getMedicamentos = () => {
      try {
        const arrayTratado = [].concat(...Medicamentos.value);
        console.log(arrayTratado)
        return aluno.value.User ? arrayTratado : '';
      } catch (err) {
        console.error(err);
        return '';
      }
    }

    const getComorbidades = () => {
      try {
        const arrayTratado = [].concat(...Comorbidades.value);
        console.log(arrayTratado)
        return aluno.value.User ? arrayTratado : '';
      } catch (err) {
        console.error(err);
        return '';
      }
    }



    return {
      clientId,
      getFirstLetter,
      NivelAtvFisica,
      idNivelAtiFis,
      data,
      nome,
      altura,
      anamnese,
      getAtividadeFisica,
      getFumante,
      getConsumoAlc,
      getMedicamentos,
      getComorbidades,
      ...toRefs(aluno),
    };
  },
});
</script>
