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
            <q-input name="email" label="Email" v-model="login.email"
              :rules="[(val) => validEmail(val) || 'O email deve ser válido']">
            </q-input>
            <q-input name="password" label="Senha" type="password" v-model="login.password" :rules="PasswordValidation">
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
import { api } from 'src/boot/axios';
import {
  Loading, QSpinnerGears
} from 'quasar'
let $q
export default defineComponent({
  name: 'LoginPage',
  setup() {
    const router = useRouter();

    const submit = async (e) => {
      try {
        Loading.show({
          message: "Aguarde...",
          spinnerColor: 'primary',
          spinnerSize: 200,
        });
        const form = new FormData(e.target);
        const inputs = Object.fromEntries(form.entries());
        console.log(inputs);

        const response = await api.post('api/login', inputs);

        if (response.status === 200) {
          Loading.hide();
          const { data } = response;
          axios.defaults.headers.common['Authorization'] = `Bearer ${data.token}`;
          localStorage.setItem('token', data.token)
          console.log("Sucesso"); // Você pode exibir uma mensagem de sucesso
          $q.notify({
            type: 'positive',
            message: "Sucesso!!",
          })
          await router.push('/');
        } else {
          $q.notify({
            type: 'negative',
            message: `${response.statusText}`,
          })
          console.error("Erro na chamada da API:", response.statusText);
          Loading.hide();
          // Aqui, você pode exibir uma mensagem de erro ao usuário
        }
      } catch (error) {
        // console.log(error.response.data.message)
        $q.notify({
          type: 'negative',
          message: `${error.response.data.message}`,
        })
        console.error("Erro na chamada da API:", error);
        Loading.hide();
        // Aqui, você pode exibir uma mensagem de erro ao usuário
      }
    };

    return {
      submit,
      showLoading() {
        $q.loading.show({
          message: 'First message. Gonna change it in 3 seconds...'
        })
      }
    };
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
    loadshow() {
      const $q = useQuasar()
      $q.loading.show({
      })
      $q.loading.hide()
    }

  },
  mounted() {
    $q = useQuasar();
  },
  computed: {
    validEmail() {

      return (email) => {
        if (typeof email !== 'string') {
          return false; // Retorna falso se não for uma string
        }
        // return true

        const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
      };
    },
    PasswordValidation() {
      return [
        (v) => !!v || "A senha não pode estar vazia.",
        (v) => v.length > 6 || "A senha deve conter 6 caracteres ou mais",
      ]
    },
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
