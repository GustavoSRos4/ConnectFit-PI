<template>
  <div>
    <q-layout view="lHr Lpr lff">

      <q-drawer v-model="leftDrawerOpen" show-if-above elevated bordered :mini="miniState" @mouseover="miniState = false"
        @mouseout="miniState = true" :width="350" :breakpoint="350" mini-width="150" class="bg-primary window-height">
        <q-card class="window-height transparent">
          <q-list padding class="column fit">
            <q-toolbar class="bg-primary text-white text-center">
              <q-img :style="miniState ? 'width: 100%' : 'width: 50%'" src="~assets/iconeAppwhite.png" />
              <q-toolbar-title class="Anton text-h4" v-if="!miniState">ConnectFit</q-toolbar-title>
            </q-toolbar>

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
      </q-drawer>

      <q-page-container>
        <q-page>
          <router-view />
        </q-page>
      </q-page-container>

    </q-layout>
  </div>
</template>


<script>
import { ref } from 'vue'

export default {
  setup() {
    const leftDrawerOpen = ref(false);
    return {
      leftDrawerOpen,
      toggleLeftDrawer() {
        leftDrawerOpen.value = !leftDrawerOpen.value
      },
      miniState: ref(true),
    }
  },
}
</script>
