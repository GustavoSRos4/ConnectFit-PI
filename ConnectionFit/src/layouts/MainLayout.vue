
<template>
  <q-layout view="hHh Lpr lff">

    <!-- Header -->
    <q-header reveal class="bg-transparent text-white q-mt-sm" height-hint="98">
      <q-toolbar>
        <q-toolbar-title>
          <q-btn align="right" to="/" rounded class="bg-primary"
            icon="img:https://pic.onlinewebfonts.com/thumbnails/icons_315544.svg" label="ConnectionFit" size="md" />
        </q-toolbar-title>
        <!-- Tabs from index  page -->
        <div>
          <q-btn class="q-mr-sm" outline rounded color="primary" :to="{ name: 'LoginPage' }">Login</q-btn>
          <q-btn outline rounded color="primary gt-sm">Sobre nós</q-btn>
          <!-- <q-btn class="q-ml-sm" outline rounded color="primary"></q-btn> -->
        </div>
        <!-- <q-tabs mobile-arrows class="gt-sm">
          <q-route-tab content-class="rounded" class="bg-primary text-white" to="/Login" label="Login" />
          <q-route-tab class="bg-primary rounded text-white" to="/page2" label="Page Two" />
          <q-route-tab class="bg-primary rounded" to="/page3" label="Page Three" />
        </q-tabs> -->

        <q-btn dense flat round icon="menu" class="lt-md" @click="toggleRightDrawer" />
      </q-toolbar>
    </q-header>

    <q-drawer v-model="rightDrawerOpen" side="right" bordered>
      <div class="row q-ma-sm">
        <q-btn push elevated rounded color="primary" class="vertical-middle col ">Sobre nós</q-btn>
      </div>
    </q-drawer>

    <q-page-container style="padding-top: 0 !important">
      <router-view />
    </q-page-container>

    <!-- <q-footer reveal elevated class="bg-grey-8 text-white">
      <q-toolbar>
        <q-toolbar-title>
          <q-avatar>
            <img src="https://cdn.quasar.dev/logo-v2/svg/logo-mono-white.svg">
          </q-avatar>
          <div>Title</div>
        </q-toolbar-title>
      </q-toolbar>
    </q-footer> -->

  </q-layout>
</template>

<script>
import LoginPage from 'src/pages/LoginPage.vue';
import { defineComponent, ref } from 'vue'

export default defineComponent({
  name: 'MainLayout',
  data() {
    return {
      rightDrawerOpen: ref(false)
    }
  },
  methods: {
    toggleRightDrawer() {
      this.rightDrawerOpen = !this.rightDrawerOpen
    }
  },
})
</script>

