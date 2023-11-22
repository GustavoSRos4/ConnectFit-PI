<template>
  <div class="row">
    <div class="col-12">
      <q-btn rounded class="bg-primary col-12" icon="add" @click="ToggleCreate">{{ create ? "Nova Ficha" :
        "Voltar"
      }}</q-btn>
    </div>
  </div>
  <div class="row">
    <div class="col" v-if="create">
      <ficha-list />
    </div>
    <div class="col" v-if="!create">
      <ficha-create :exercicios="exercicios" />
    </div>
  </div>
</template>

<script>
import { defineComponent, ref, onMounted } from 'vue';
import FichaList from 'src/components/FichaList.vue'
import FichaCreate from 'src/components/FichaCreate.vue'
import { api } from 'src/boot/axios';


export default defineComponent({
  components: { FichaList, FichaCreate },
  name: 'FichaMenu',

  setup() {
    const create = ref(true)
    const exercicios = ref({})
    const ToggleCreate = () => {
      create.value = !create.value
    }

    const fetchExercicios = async (tentativas) => {
      if (tentativas === 0) {
        console.log("Número de tentativas esgotado. Desistindo...");
        return;
      }

      try {
        console.log(`Tentativa ${11 - tentativas}`);
        const res = await api.get('api/showExercicio');
        exercicios.value = [...res.data.Exercicios];
      } catch (err) {
        console.log(err);
        await new Promise(resolve => setTimeout(resolve, 1000));
        await fetchExercicios(tentativas - 1);
      }
    };

    onMounted(async () => {
      await fetchExercicios(10);
    });

    return {
      create,
      ToggleCreate,
      exercicios,
    }
  },
});
</script>
