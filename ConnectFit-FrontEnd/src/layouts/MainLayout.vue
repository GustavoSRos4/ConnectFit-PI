<template>
  <div>
    <q-layout view="lHr Lpr lff">

      <q-drawer v-model="leftDrawerOpen" show-if-above elevated bordered :mini="miniState" @mouseover="miniState = false"
        @mouseout="miniState = true" :width="350" :breakpoint="350" mini-width="150" class="bg-primary">
        <q-scroll-area class="fit" :horizontal-thumb-style="{ opacity: 0 }">

          <q-toolbar class="bg-primary text-white shadow-2 text-center">
            <q-img :style="miniState ? 'width: 100%' : 'width: 50%'" src="~assets/iconeAppwhite.png" />
            <q-toolbar-title class="Anton text-h4" v-if="!miniState">ConnectFit</q-toolbar-title>
          </q-toolbar>
          <q-list padding>
            <q-item clickable v-ripple>
              <q-item-section avatar>
                <q-icon name="dashboard" />
              </q-item-section>

              <q-item-section class="Anton text-h6">
                DashBoard
              </q-item-section>
            </q-item>

            <q-item clickable v-ripple>
              <q-item-section avatar>
                <q-icon name="perm_identity" />
              </q-item-section>

              <q-item-section class="Anton text-h6">
                Alunos
              </q-item-section>
            </q-item>

            <q-item clickable v-ripple>
              <q-item-section avatar>
                <q-icon name="edit_square" />
              </q-item-section>

              <q-item-section class="Anton text-h6">
                Exercícios
              </q-item-section>
            </q-item>

            <q-separator />

            <q-item clickable v-ripple text-center>
              <q-item-section avatar>
                <q-icon name="account_circle" />
              </q-item-section>

              <q-item-section class="text-h6 text-weight-regular Anton">
                Gustavo Silvério
                <p class="text-subtitle2 Anton">
                  Personal Trainer
                </p>
              </q-item-section>
            </q-item>
          </q-list>
        </q-scroll-area>
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
    const leftDrawerOpen = ref(false)

    return {
      leftDrawerOpen,
      toggleLeftDrawer() {
        leftDrawerOpen.value = !leftDrawerOpen.value
      },
      miniState: ref(true),
    }
  }
}
</script>
