<template>
  <div>
    <q-layout view="lHr Lpr lff">

      <q-drawer v-model="leftDrawerOpen" show-if-above elevated bordered :mini="!leftDrawerOpen || miniState"
        @click.capture="drawerClick" :width="350" :breakpoint="350" :mini-width="150" class="bg-primary window-height">
        <q-card class="window-height transparent">
          <q-list padding class="column fit">
            <q-item>
              <q-toolbar class="bg-primary text-white">
                <q-img src="~assets/iconeAppwhite.png" :style="miniState ? 'max-width: 150px;' : 'max-width: 120px;'" />
                <q-toolbar-title class=" Anton text-h4" v-if="!miniState">ConnectFit</q-toolbar-title>
              </q-toolbar>
            </q-item>
            <q-separator spaced inset />

            <q-item clickable v-ripple class="col" :to="{ name: 'IndexDashboard' }
              ">
              <q-item-section avatar>
                <q-icon name="dashboard" />
              </q-item-section>

              <q-item-section class="text-subtitle1">
                DashBoard
              </q-item-section>
            </q-item>

            <q-item clickable v-ripple class="col" :to="{ name: 'AlunosDashboard' }">
              <q-item-section avatar>
                <q-icon name="perm_identity" />
              </q-item-section>

              <q-item-section class="text-subtitle1">
                Alunos
              </q-item-section>
            </q-item>

            <q-item clickable v-ripple class="col" :to="{ name: 'ExerciciosDashboard' }">
              <q-item-section avatar>
                <q-icon name="edit_square" />
              </q-item-section>

              <q-item-section class="text-subtitle1">
                Exercícios
              </q-item-section>
            </q-item>

            <q-separator spaced inset />

            <q-item clickable v-ripple text-center class="col">
              <q-item-section avatar>
                <q-icon name="account_circle" />
              </q-item-section>

              <q-item-section class="text-subtitle1 text-weight-regular">
                Gustavo Silvério
                <p class="text-caption">Personal Trainer</p>
              </q-item-section>
            </q-item>
          </q-list>
        </q-card>
        <div class="q-mini-drawer-hide absolute" style="top: 100px; right: -17px; z-index: 999;">
          <q-btn dense round elevated color="dark" icon="arrow_back" @click="miniState = true" />
        </div>
      </q-drawer>

      <q-page-container v-show="islogged">
        <q-page>
          <router-view />
        </q-page>
      </q-page-container>

    </q-layout>
  </div>
</template>


<script>
import { ref, onMounted } from 'vue'
import { api } from 'src/boot/axios.js';
import axios from 'axios';
import { Loading } from 'quasar'
import { frase_aleatoria } from '../utils/validar'

export default {
  setup() {
    const islogged = ref(false);

    const realizarChamada = async (tentativasRestantes) => {
      const frase = frase_aleatoria();
      Loading.show({
        message: `${frase} <br /><span class="text-amber text-italic">Please wait...</span>`,
        html: true,
        spinnerColor: 'primary',
        spinnerSize: 200,
      });
      try {
        const response = await api.get('api/mostrarPessoa');
        console.log(response);
        islogged.value = true;
      } catch (error) {
        if (tentativasRestantes > 0) {
          console.error(`Erro na tentativa. Tentativas restantes: ${tentativasRestantes}`);
          await new Promise((resolve) => setTimeout(resolve, 1000)); // Espera 1 segundo entre as tentativas
          await realizarChamada(tentativasRestantes - 1); // Tenta novamente com uma tentativa a menos
        } else {
          this.$q.notify({
            type: 'negative',
            message: `Falha após 10 tentativas. Por favor, tente novamente mais tarde.`,
          });
          console.error('Falha após 10 tentativas.');
        }
      } finally {
        Loading.hide();
      }
    };

    onMounted(async () => {
      realizarChamada(10);
    })

    const leftDrawerOpen = ref(false);
    const miniState = ref(true)

    return {
      leftDrawerOpen,
      islogged,
      miniState,
      drawerClick(e) {
        if (miniState.value) {
          miniState.value = false
        }
      },
    }
  },
  methods: {
    async buscarDados() {
      await api.get('api/mostrarPessoa').then(response => {
        console.log(response);
        islogged.value = true;
      }).catch(response => {
        this.$q.notify({
          type: 'negative',
          message: `${response.response.data.errors}`,
        })
        console.error(response.response.data.errors);
      });
    }
  },
  data() {
    return {
      user: null,
    };
  },
}
</script>
