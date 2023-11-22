<template>
  <div class="q-pa-md">
    <div>Teste</div>
    <q-btn @click="teste">asdads</q-btn>
  </div>
</template>

<script>
import { useRoute } from 'vue-router';
import { defineComponent } from 'vue';
export default defineComponent({
  name: 'FichaList',
  setup() {
    const route = useRoute();
    const clientId = route.params.id;
    const teste = () => {
      console.log(clientId);
    }
    return {
      teste,
    }
  }
})
</script>
