<template>
  <div class="q-pa-md" @prevent="submit">
    <q-input v-model.lazy="inputData.descricao" :rules="[required]" label="Descrição"></q-input>

    <q-select filled v-model="model" :options="exerciciosfilter" option-label="Nome" label="Exercicios" multiple
      emit-value map-options use-input @filter="filter">

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
        <div class="q-ma-md q-py-md">
          <div class="row">
            <div class="col-12 text-h6 text-primary">
              {{ item.Nome }}
            </div>
            <div class="col-12 text-caption text-italic">
              {{ item.Descricao }}
            </div>
            <q-input class="col-md-4 col-sm-12 q-px-md" name="Repeticoes" label="Repetições"
              v-model.lazy="item.Repeticoes" :rules="[required]" lazy-rules type="number" />
            <q-input class="col-md-4 col-sm-12 q-px-md" name="Descanso" label="Tempo de descanso"
              v-model.lazy="item.descanso" :rules="[required]" lazy-rules type="number">
              <template v-slot:append>
                <div>seg</div>
              </template>
            </q-input>
            <q-input class="col-md-4 col-sm-12 q-px-md" name="Carga" label="Carga" v-model.lazy="item.Carga" lazy-rules
              type="number">
              <template v-slot:append>
                <div>kg</div>
              </template>
            </q-input>
            <q-input class="col-md-6 col-sm-12 q-px-md" name="linkVideo" label="Link do vídeo de execução"
              v-model.lazy="item.linkVideo" :rules="[required]" lazy-rules />
          </div>
        </div>
      </q-card>
    </div>
    <div class="q-pa-md">
      <q-btn @click="enviarDados" outline color="primary" label="Salvar"></q-btn>
    </div>
  </div>
</template>

<script>
import { defineComponent, ref } from 'vue';
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
  setup() {
    return {
      required,
      model: ref([]),
    }
  },
  data() {
    return {
      inputData: {
        descricao: "",
      },
      exerciciosfilter: []
    };
  },
  methods: {
    enviarDados() {
      // Em vez de chamar onDataSubmit diretamente, emita um evento
      this.$emit('dados-atualizados', {
        index: this.index,
        descricao: this.inputData.descricao,
        ExerciciosTreino: [...this.model],
      });
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
