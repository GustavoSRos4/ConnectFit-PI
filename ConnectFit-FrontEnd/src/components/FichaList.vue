<template>
  <div class="q-pa-md">
    <q-card class="row">
      <div class=" col-12" v-for="item in Fichas" :key="item.Ficha.idFicha">
        <q-expansion-item icon="wysiwyg" :label="item.Ficha.nomeFicha" class="">
          <q-expansion-item switch-toggle-side :header-inset-level="1" v-for="treino in item.Treinos"
            :label="treino.Treino.Descricao" :key="treino.id">
            <div class="bg-primary" v-for="exercicios in treino.Exercicios" :key="exercicios.idExercicio">
              <div class="row q-pb-md">
                <div class="col-12 flex column flex-center">
                  <span class="text-caption">Nome</span>
                  <span class="row q-pl-sm text-h6">{{ getNome(exercicios.idExercicio) }}</span>
                </div>
                <div class="col-12 flex flex-center">
                  <span class="row q-pl-sm text-white text-body1">{{ exercicios.Descricao }}</span>
                </div>
              </div>
              <div class="row">
                <div class="col-md-3 col-sm-6 col-xs-12 flex column flex-center">
                  <span class="text-caption">Repetições</span>
                  <span class="row q-pl-sm text-h6">{{ exercicios.Repeticoes }}</span>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12 flex column flex-center">
                  <span class="text-caption">Descanso</span>
                  <span class="row q-pl-sm text-h6">{{ exercicios.Descanso }} seg</span>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12 flex column flex-center">
                  <span class="text-caption">Carga</span>
                  <span class="row q-pl-sm text-h6">{{ exercicios.Carga }} kg</span>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12 flex column flex-center">
                  <span class="text-caption">Link video referência</span>
                  <a class="row q-pl-sm text-h6 text-white" target="_blank" @click="open(exercicios.linkVideo)">{{
                    exercicios.linkVideo }}</a>
                </div>
              </div>
              <q-separator class="q-my-sm " />
            </div>
          </q-expansion-item>
        </q-expansion-item>
      </div>
    </q-card>

  </div>
</template>

<script>
import { useRoute } from 'vue-router';
import { defineComponent, onMounted, ref } from 'vue';
import { api } from 'src/boot/axios';
import { openURL } from 'quasar'

export default defineComponent({
  name: 'FichaList',
  props: {
    exercicios: {
      type: Array,
      required: true,
    },
  },
  setup(props) {
    const route = useRoute();
    const clientId = route.params.id;
    const Fichas = ref();

    onMounted(async () => {
      await fetchAluno(10);
    });

    const open = (link) => {
      openURL(`https://${link}`)
    };

    const fetchAluno = async (tentativas) => {
      if (tentativas === 0) {
        console.log("Número de tentativas esgotado. Desistindo...");
        return;
      }

      try {
        console.log(`Tentativa ${11 - tentativas} Aluno.`);
        const res = await api.get(`api/showDataAluno/${route.params.id}`);
        Fichas.value = res.data.Fichas;
      } catch (err) {
        console.log(err);
        await new Promise(resolve => setTimeout(resolve, 1000));
        await fetchAluno(tentativas - 1);
      }
    };

    const getNome = (id) => {

      for (var i = 0; i < props.exercicios.length; i++) {
        if (props.exercicios[i].idExercicio == id) {
          return props.exercicios[i].Nome
          break;
        };
      }

      return id;
    }



    return {
      open,
      getNome,
      Fichas,
    }
  }
})
</script>
