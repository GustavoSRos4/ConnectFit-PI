<template>
  <img src="~assets/wave.svg" class="wave" alt="login-wave">
  <div class="row q-pl-lg" style="height: 90vh">
    <div class="col-0 col-md-6 col-xl-6 flex justify-center content-center">
      <img src="~assets/trainerimg.svg" class="responsive" alt="login-image">
    </div>
    <div class="col-12 col-md-6 col-xl-6 flex content-center justify-center">
      <q-card v-bind:style="$q.screen.lt.sm ? { 'width': '80%' } : { 'width': '50%' }">
        <q-card-section>
          <q-avatar size="90px" class="absolute-center shadow-10 bg-primary">
            <img src="https://pic.onlinewebfonts.com/thumbnails/icons_315544.svg" alt="avatar">
          </q-avatar>
        </q-card-section>
        <q-card-section>
          <div class="q-pt-lg">
            <div class="col text-h6 ellipsis flex justify-center">
              <h2 class="text-h4 text-uppercase q-my-none text-weight-regular">Login</h2>
            </div>
          </div>
        </q-card-section>
        <q-card-section>
          <q-form class="q-gutter-md" @submit.prevent="submit">
            <q-input name="email" label="Email" v-model="login.email">
            </q-input>
            <q-input name="password" label="Senha" type="password" v-model="login.password">
            </q-input>
            <div>
              <q-btn class="full-width" color="primary" label="Login" type="submit" rounded></q-btn>
              <div class="text-center q-mt-sm q-gutter-lg">
                <router-link class="text-white" to="/login">Esqueceu a senha?</router-link>
                <router-link class="text-white" :to="{ name: 'Signup' }">Criar conta</router-link>
              </div>
            </div>
          </q-form>
        </q-card-section>
      </q-card>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue';
import { useQuasar } from 'quasar';
import { useRouter } from "vue-router";
import axios from "axios";

let $q
export default defineComponent({
  name: 'LoginPage',
  setup() {
    const router = useRouter();

    const submit = async e => {
      const form = new FormData(e.target);

      const inputs = Object.fromEntries(form.entries());
      console.log(inputs);
      const { data } = await axios.post('login', inputs, {
        withCredentials: true
      });

      axios.defaults.headers.common['Authorization'] = `Bearer ${data.token}`;

      await router.push('/');
    }

    return {
      submit
    }
  },
  data() {
    return {
      login: {
        email: '',
        password: ''
      }
    }
  },

  methods: {
    submitLogin() {
      if (!this.login.username || !this.login.password) {
        $q.notify({
          type: 'negative',
          message: 'Os dados informados são inválidos.'
        })
      } else if (this.login.password.length < 6) {
        $q.notify({
          type: 'negative',
          message: 'Sua senha deve ter no mínimo 6 caracteres.'
        })
      } else {
        loadshow();
        $q.notify({
          type: 'positive',
          message: 'Logado com Sucesso!!'
        })
      }
    },
    loadshow() {
      const $q = useQuasar()
      $q.loading.show({
      })
      $q.loading.hide()
    }

  },
  mounted() {
    $q = useQuasar();
  }
})
</script>

<style scoped>
.wave {
  position: fixed;
  height: 100%;
  left: 0;
  bottom: 0;
  z-index: -1;
}
</style>
