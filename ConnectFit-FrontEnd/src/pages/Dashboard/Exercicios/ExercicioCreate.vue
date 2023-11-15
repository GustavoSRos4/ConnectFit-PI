<template>
  <div class="q-pa-lg">
    <q-btn label="Voltar" @click="Voltar" icon="arrow_back">
    </q-btn>
    <q-card class="q-pa-md">
      <q-form class="q-gutter-md" @submit.prevent="submit">
        <div class="row">
          <q-input class="col-md-6 col-sm-12 q-px-md" name="Nome" label="Nome" v-model="exercicio.Nome"
            :rules="[required]" lazy-rules>
          </q-input>
          <q-input class="col-md-6 col-sm-12 q-px-md" name="Descricao" label="Descrição" v-model="exercicio.Descricao"
            lazy-rules>
          </q-input>
        </div>
        <div class="row">
          <q-input class="col-md-4 col-sm-12 q-px-md" name="Repeticoes" label="Repetições" v-model="exercicio.Repeticoes"
            :rules="[required]" lazy-rules type="number" />
          <q-input class="col-md-4 col-sm-12 q-px-md" name="Carga" label="Carga" v-model="exercicio.Carga" lazy-rules
            type="number">
            <template v-slot:append>
              <div>kg</div>
            </template>
          </q-input>
          <q-input class="col-md-4 col-sm-12 q-px-md" name="Descanso" label="Tempo de descanso"
            v-model="exercicio.Descanso" :rules="[required]" lazy-rules type="number">
            <template v-slot:append>
              <div>seg</div>
            </template>
          </q-input>
        </div>
        <div class="row">
          <q-input class="col-md-6 col-sm-12 q-px-md" name="Musculo" label="Nome do músculo " v-model="exercicio.Musculo"
            :rules="[required]" lazy-rules />
          <q-input class="col-md-6 col-sm-12 q-px-md" name="linkVideo" label="Link do vídeo de execução"
            v-model="exercicio.linkVideo" :rules="[required]" lazy-rules />
        </div>
        <div class="row">
          <q-btn class="full-width" color="primary" label="Criar" type="submit" rounded></q-btn>
        </div>
      </q-form>
    </q-card>
  </div>
</template>

<script>

import { defineComponent } from 'vue';
import { required } from 'src/utils/validar';
import { Loading, useQuasar } from 'quasar';
import { useRouter } from "vue-router";
import { api } from 'src/boot/axios';

export default defineComponent({
  name: 'ExercicioCreate',

  setup() {
    const $q = useQuasar();
    const router = useRouter();
    const submit = async (e) => {
      Loading.show({
        message: "Aguarde...",
        spinnerColor: 'primary',
        spinnerSize: 200,
      });

      const form = new FormData(e.target);
      const inputs = Object.fromEntries(form.entries());
      if (inputs.Repeticoes && inputs.Carga && inputs.Descanso) {
        inputs.Repeticoes = parseInt(inputs.Repeticoes, 10); // A base 10 é comumente usada
        inputs.Carga = parseInt(inputs.Carga, 10); // A base 10 é comumente usada
        inputs.Descanso = parseInt(inputs.Descanso, 10); // A base 10 é comumente usada
      }

      console.log(inputs);

      await api.post('api/createExercicio', inputs).then(res => {
        console.log(res);
        $q.notify({
          type: 'positive',
          message: `${res.data.message}`,
        })
        router.push({ name: 'ExerciciosDashboard' });
      }).catch(err => {
        console.log(err);
      }).finally(() => {
        Loading.hide();
      });
      // const response = await api.post('api/createExercicio', inputs);
      // console.log(response);
      // if (response.status === 201) {
      //   Loading.hide();
      //   const { data } = response;
      //   console.log("Sucesso"); // Você pode exibir uma mensagem de sucesso
      //   $q.notify({
      //     type: 'positive',
      //     message: "Sucesso!!",
      //   })
      //   await router.push({ name: 'ExerciciosDashboard' });
      // } else {
      //   $q.notify({
      //     type: 'negative',
      //     message: `${response.statusText}`,
      //   })
      //   console.error("Erro na chamada da API:", response.statusText);
      //   Loading.hide();
      // Aqui, você pode exibir uma mensagem de erro ao usuário
    }
    const Voltar = () => {
      router.back();
    };
    return { submit, Voltar }
  },
  data() {
    return {
      exercicio: {
        Nome: '',
        Musculo: '',
        Repeticoes: 0,
        Descanso: 0,
        Carga: '',
        linkVideo: '',
        Descricao: '',
      },
    };
  },
  methods: {
    required,
  },
});
</script>
