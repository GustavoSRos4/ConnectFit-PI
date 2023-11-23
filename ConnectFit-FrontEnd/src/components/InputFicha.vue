<template>
  <div class="q-pa-md">
    <q-input v-model="inputData.descricao" :rules="[required]" label="Nome" />

    <q-select filled v-model="model" :options="exerciciosfilter" option-label="Nome" label="Exercicios" multiple
      emit-value map-options use-input @filter="filter" @update:model-value="enviarDados()">

      <template v-slot:option="{ itemProps, opt, selected, toggleOption }">
        <q-item v-bind="itemProps">
          <q-item-section>
            <q-item-label> {{ opt.Nome }}</q-item-label>
          </q-item-section>
          <q-item-section side>
            <q-toggle :model-value="selected" @update:model-value="toggleOption(opt)" />
          </q-item-section>
        </q-item>
      </template>
    </q-select>

    <div v-for="item in model" :key="item.id">
      <q-card>
        <div class="q-ma-md q-py-md ">
          <div class="row">
            <div class="col-12 text-h6 text-primary">
              {{ item.Nome }}
            </div>
            <div class="col-12 text-caption text-italic">
              {{ item.Descricao }}
            </div>
            <q-input class="col-md-4 col-sm-12 q-px-md" v-on:change="handleInputChange()" name="Repeticoes"
              label="Repetições" v-model.lazy="item.Repeticoes" :rules="[required]" lazy-rules type="number" />
            <q-input class="col-md-4 col-sm-12 q-px-md" name="Descanso" label="Tempo de descanso"
              v-model.lazy="item.Descanso" v-on:change="handleInputChange()" :rules="[required]" lazy-rules type="number">
              <template v-slot:append>
                <div>seg</div>
              </template>
            </q-input>
            <q-input class="col-md-4 col-sm-12 q-px-md" name="Carga" label="Carga" v-model.lazy="item.Carga" lazy-rules
              type="number" v-on:change="handleInputChange()">
              <template v-slot:append>
                <div>kg</div>
              </template>
            </q-input>
            <q-input class="col-md-6 col-sm-12 q-px-md" name="linkVideo" label="Link do vídeo de execução"
              v-model="item.linkVideo" v-on:change="handleInputChange()" :rules="[required]" lazy-rules />
          </div>
        </div>
      </q-card>
    </div>
    <div class="q-pa-md">
      <q-btn @click="enviarDados" :icon="salvo ? 'check' : 'warning'" outline :color="salvo ? 'primary' : 'yellow'"
        label="Salvar"></q-btn>
    </div>
  </div>
</template>

<script>
import { defineComponent, ref, watch, onMounted } from 'vue';
import { required } from 'src/utils/validar';

export default defineComponent({
  name: 'InputFicha',
  props: {
    exercicios: {
      type: Array,
      required: true,
    },
    index: {
      type: Number,
      required: true,
    },
  },
  setup(props, { emit }) {
    const salvo = ref(false);
    const inputData = ref({
      descricao: "",
    });
    const model = ref([]);

    onMounted(() => {
      enviarDados(10);
    })

    watch(salvo, (newValue, oldValue) => {
      if (newValue !== oldValue) {
        enviarDados()
      }
    });

    const enviarDados = () => {
      if (!Array.isArray(model.value)) {
        model.value = [];
      }

      salvo.value = true

      emit('dados-atualizados', {
        index: props.index,
        descricao: inputData.value.descricao,
        ExerciciosTreino: [...model.value],
      });
    };

    return {
      required,
      model,
      salvo,
      enviarDados,
      inputData,
    }
  },
  data() {
    return {
      exerciciosfilter: []
    };
  },
  methods: {
    handleInputChange() {
      // console.log("teste1");
      this.salvo = false;
      // console.log(this.salvo);
    },


    filter(val, update, abort) {
      update(() => {
        const search = val.toLowerCase();
        this.exerciciosfilter = this.exercicios.filter(v => v && v.Nome && v.Nome.toLowerCase().indexOf(search) > -1);
      });
    },

    toggleOption(opt) {
      if (this.model.includes(opt)) {
        this.model = this.model.filter((item) => item !== opt);
      } else {
        this.model.push(opt);
      }
      this.enviarDados();
    },
  },
});
</script>
