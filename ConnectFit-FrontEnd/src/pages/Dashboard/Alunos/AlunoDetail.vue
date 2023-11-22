<template>
  <div>
    <q-card class="q-pa-md">
      <q-tabs v-model="tab" dense class="text-grey" active-color="primary" indicator-color="primary" align="justify"
        narrow-indicator>
        <q-tab name="aluno" label="Aluno" />
        <q-tab name="ficha" label="Ficha" />
      </q-tabs>
      <q-tab-panels v-model="tab" animated keepAlive>
        <q-tab-panel name="aluno" class="q-pa-none q-ma-none">

          <aluno-detail-component />

        </q-tab-panel>
      </q-tab-panels>

      <q-tab-panels v-model="tab" animated keepAlive>
        <q-tab-panel name="ficha">

          <ficha-menu />

        </q-tab-panel>
      </q-tab-panels>
    </q-card>
  </div>
</template>

<script>
import { defineComponent, ref } from 'vue';

import AlunoDetailComponent from 'src/components/AlunoDetailComponent.vue'
import FichaMenu from 'src/components/FichaMenu.vue';


export default defineComponent({
  components: { AlunoDetailComponent, FichaMenu },
  name: 'AlunoDetail',
  setup() {
    return {
      tab: ref('aluno'),
    }
  },
});
</script>
