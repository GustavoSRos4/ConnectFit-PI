<template>
  <div>
    <div>
      <div class="q-pa-md">
        <q-input label="Nome da ficha" v-model="fichaNome"></q-input>
      </div>

      <q-list bordered>
        <q-expansion v-model="expansionModel">
          <q-expansion-item group="a" header-class="bg-primary text-white text-center "
            v-for="(item, index) in expansionModel" :key="index" :label="`Treino ${index + 1}`">
            <InputFicha :index="index" :exercicios="exercicios" @dados-atualizados="tratarDados" />
          </q-expansion-item>
          <q-separator />
        </q-expansion>
      </q-list>

      <div class="q-pa-md flex justify-between">
        <q-btn @click="adicionarItem" color="primary" push icon="add">Novo Treino</q-btn>
        <q-btn @click="submit" color="primary" push icon="check">Cadastrar Treino</q-btn>
      </div>
    </div>
  </div>
</template>

<script>
import { useRoute } from 'vue-router';
import { defineComponent, ref, reactive } from 'vue';
import InputFicha from 'src/components/InputFicha.vue'
import { Loading, useQuasar } from 'quasar';
import { api } from 'src/boot/axios';
import { stringify } from 'postcss';

export default defineComponent({
  components: {
    InputFicha, // Registre o componente InputComponent
  },
  props: {
    exercicios: {
      type: Array,
      required: true,
    }
  },
  name: 'FichaCreate',
  setup() {
    const $q = useQuasar();
    const route = useRoute();
    const clientId = ref(parseInt(route.params.id, 10));
    const objetosRecebidos = reactive([]);
    const fichaNome = ref("");


    function renameProperties(obj, mappings) {
      const result = {};
      for (const key in obj) {
        const newKey = mappings[key] || key;
        result[newKey] = typeof obj[key] === 'object' ? renameProperties(obj[key], mappings) : obj[key];
      }
      return result;
    }

    // Função para criar uma cópia com as propriedades renomeadas
    function copyWithLowercaseProps(original) {
      const mappings = {
        "Carga": "carga",
        "Descanso": "descanso",
        "linkVideo": "linkvideo"
        // Adicione mais mapeamentos se necessário
      };

      const copied = JSON.parse(JSON.stringify(original)); // Cópia profunda para evitar alterar o original

      // Renomeie as propriedades dentro de cada exercício
      copied.Treinos.forEach(treino => {
        treino.ExerciciosTreino.forEach(exercicio => {
          exercicio = renameProperties(exercicio, mappings);
        });
      });

      // Renomeie as propriedades dentro de cada treino
      copied.Treinos = copied.Treinos.map(treino => renameProperties(treino, mappings));

      return copied;
    }




    const tratarDados = (dados) => {
      const index = dados.index;
      console.log(index)
      console.log(dados)

      if (index != undefined && index != null && (objetosRecebidos[index] != undefined)) {
        // Se o índice existe, atualize o objeto no array
        console.log("existe");
        objetosRecebidos[index] = dados;
      } else {
        console.log("não existe");
        // Se o índice não existe, adicione o objeto ao array
        objetosRecebidos.push(dados);
      }

      console.log('Objetos Agregados:', objetosRecebidos);
    };


    const teste = () => {
      console.log(objetosRecebidos);
    };

    const expansionModel = ref([]);

    const adicionarItem = () => {
      expansionModel.value.push(true); // Adicione um item ao modelo para expandir o próximo
    };

    const submit = async (e) => {
      const camposRemovidos = ['Musculo', 'created_at', 'updated_at', 'index', 'Nome'];

      const dadosSemCampos = objetosRecebidos.map(item => {
        const novoItem = { ...item };

        camposRemovidos.forEach(campo => {
          delete novoItem[campo];
        });

        // Remover campos dentro de ExerciciosTreino(Musculo, created_at, updated_at, Nome, index)
        novoItem.ExerciciosTreino = novoItem.ExerciciosTreino.map(exercicio => {
          const novoExercicio = { ...exercicio };

          camposRemovidos.forEach(campo => {
            delete novoExercicio[campo];
          });

          return novoExercicio;
        });

        return novoItem;
      });

      const inputs = {
        Treinos: dadosSemCampos,
        idPessoaUsuario: clientId.value,
        nomeFicha: fichaNome.value,
      };

      // console.log('Inputs:', inputs);
      const inputLowerCase = copyWithLowercaseProps(inputs);
      const treinosString = JSON.stringify(inputLowerCase.Treinos);

      await api.post('api/createFicha', { Treinos: treinosString, idPessoaUsuario: inputLowerCase.idPessoaUsuario, nomeFicha: inputLowerCase.nomeFicha }).then(res => {
        console.log(res);
        $q.notify({
          type: 'positive',
          message: `${res.data.message}`,
        })
      }).catch(err => {
        console.log(err);
      }).finally(() => {
        Loading.hide();
      });

    };



    return {
      clientId,
      teste,
      expansionModel,
      adicionarItem,
      objetosRecebidos,
      tratarDados,
      submit,
      fichaNome,
    };
  },
});
</script>
