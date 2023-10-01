<template>
  <img src="~assets/wave.svg" class="wave" alt="login-wave">
  <div class="geral row q-pa-lg justify-center">
    <div class="col-12 col-md-6 flex content-center justify-center">
      <q-card class="q-pt-lg teste1" v-bind:style="$q.screen.lt.sm ? { 'width': '80%' } : { 'width': '80%' }">
        <q-card-section>
          <q-avatar size="90px" class="absolute-center shadow-10 bg-primary">
            <img src="https://pic.onlinewebfonts.com/thumbnails/icons_315544.svg" alt="avatar">
          </q-avatar>
        </q-card-section>
        <q-card-section>
          <div class="q-pt-md">
            <div class="col text-h6 ellipsis flex justify-center">
              <h2 class="text-h4 text-uppercase q-my-none text-weight-regular">Registrar</h2>
            </div>
          </div>
        </q-card-section>
        <q-card-section>
          <q-form class="q-gutter-md">
            <q-stepper v-model="step" color="primary" animated ref="Stepper" contracted keep-alive>
              <q-step :name="1" title="Passo 1" :done="step > 1">
                <div class="q-mx-sm">
                  <q-input ref="fieldUsername" label="Nome de Usuário" v-model="login.username" lazy-rules
                    :rules="UsernameValidation">
                  </q-input>
                  <q-input ref="fieldRefPass" label="Senha" :type="isPwd ? 'password' : 'text'" v-model="login.password"
                    lazy-rules :rules="PasswordValidation">
                    <template v-slot:append>
                      <q-icon :name="isPwd ? 'visibility' : 'visibility_off'" class="cursor-pointer"
                        @click="isPwd = !isPwd"></q-icon>
                    </template>
                  </q-input>
                  <q-input ref="fieldRefRePass" label="Repetir Senha" :type="isPwd2 ? 'password' : 'text'"
                    v-model="login.repassword" :rules="RePasswordValidation" lazy-rules>
                    <template v-slot:append>
                      <q-icon :name="isPwd2 ? 'visibility' : 'visibility_off'" class="cursor-pointer"
                        @click="isPwd2 = !isPwd2"></q-icon>
                    </template>
                  </q-input>
                </div>
              </q-step>

              <q-step :name="2" title="Passo 2" :done="step > 2">
                <div class="q-mx-sm">
                  <q-input ref="fieldEmail" label="Email" v-model="login.email" lazy-rules
                    :rules="[(val) => validEmail(val) || 'O email deve ser válido']">
                  </q-input>
                  <q-input ref="fieldCPF" label="CPF" v-model="login.CPF" lazy-rules unmasked-value mask="###.###.###-##"
                    @input="login.CPF = parseInt(login.CPF)"
                    :rules="[(val) => validarCPF(val) || 'O cpf deve ser válido']"></q-input>

                  <q-input v-model="login.dataNasc" mask="##/##/####" ref="fieldDataNasc"
                    :rules="[(val) => validDateBr(val) || 'A data de nascimento deve ser válida']">
                    <template v-slot:append>
                      <q-icon name="event" class="cursor-pointer">
                        <q-popup-proxy cover transition-show="scale" transition-hide="scale">
                          <q-date v-model="login.dataNasc" calendar="gregorian" mask="DD/MM/YYYY">
                            <div class="row items-center justify-end">
                              <q-btn v-close-popup label="Close" color="primary" flat />
                            </div>
                          </q-date>
                        </q-popup-proxy>
                      </q-icon>
                    </template>
                  </q-input>
                </div>
              </q-step>

              <q-step :name="3" title="Passo 3" :done="step > 3">
                <q-scroll-area style="height: 300px;">
                  <p>TERMOS DE LICENÇA DO USUÁRIO FINAL (EULA) - CONNECTIONFIT</p>

                  <p> Este Termo de Licença do Usuário Final ("EULA") é um acordo legal entre você (doravante referido
                    como
                    "Usuário") e [Nome da Empresa] (doravante referida como "ConnectionFit"). Este EULA regula o uso do
                    aplicativo móvel ConnectionFit e quaisquer serviços relacionados (doravante referidos como
                    "Aplicativo").</p>

                  <ul>
                    <li>1. Aceitação dos Termos

                      Ao instalar, acessar ou usar o Aplicativo, o Usuário concorda com os termos e condições deste EULA.
                      Se
                      o
                      Usuário não concordar com estes termos, não deverá usar o Aplicativo.
                    </li>
                    <li>
                      2. Dados Pessoais e de Saúde

                      O Aplicativo pode coletar e armazenar dados pessoais e de saúde do Usuário, incluindo, mas não se
                      limitando a:

                      Medidas do corpo, como peso, altura, IMC, etc.
                      Informações de saúde, como histórico de doenças, alergias, condições médicas, medicações, etc.
                      Outras informações fornecidas voluntariamente pelo Usuário.
                    </li>
                    <li>
                      3. Uso e Armazenamento de Dados

                      O ConnectionFit usará os dados pessoais e de saúde do Usuário para:

                      Fornecer serviços personalizados relacionados à saúde e bem-estar.
                      Melhorar a qualidade e a eficácia do Aplicativo.
                      Cumprir as leis e regulamentos aplicáveis.
                      Os dados do Usuário serão armazenados de forma segura e serão acessíveis apenas para fins internos
                      da
                      ConnectionFit. Não compartilharemos seus dados com terceiros sem seu consentimento explícito.
                    </li>
                    <li>
                      4. Consentimento Informado

                      O Usuário concorda em fornecer informações precisas e atualizadas. O Usuário também compreende que o
                      uso
                      do Aplicativo é de sua própria responsabilidade e que a ConnectionFit não assume responsabilidade
                      por
                      quaisquer ações tomadas com base nas informações fornecidas.
                    </li>
                    <li>
                      5. Privacidade e Segurança

                      A ConnectionFit adota medidas razoáveis para proteger a privacidade e a segurança dos dados do
                      Usuário.
                      No
                      entanto, nenhum sistema é totalmente seguro, e a ConnectionFit não pode garantir a segurança
                      absoluta
                      dos
                      dados.
                    </li>
                    <li>
                      6. Encerramento

                      A ConnectionFit se reserva o direito de encerrar a conta do Usuário e excluir seus dados a qualquer
                      momento, se o Usuário violar este EULA ou se a empresa decidir encerrar o Aplicativo.
                    </li>
                    <li>
                      7. Alterações nos Termos

                      A ConnectionFit se reserva o direito de modificar este EULA a qualquer momento. As alterações
                      entrarão
                      em
                      vigor após a publicação das versões atualizadas no Aplicativo. O uso contínuo do Aplicativo após a
                      modificação será considerado como aceitação das alterações.
                    </li>
                    <li>
                      8. Contato

                      Para entrar em contato com a ConnectionFit ou fazer perguntas sobre este EULA, envie um email para
                      [Endereço de Email de Suporte].
                    </li>
                  </ul>
                </q-scroll-area>
                <div>
                  <q-checkbox v-model="aceiteEULA" label="Declaro que li e concordo com o EULA" color="primary" />
                </div>

              </q-step>

              <template v-slot:navigation>
                <q-stepper-navigation>
                  <div class="row">
                    <q-btn v-show="step > 1" flat color="primary" @click="$refs.Stepper.previous()" label="Voltar"
                      class="col q-mt-md flex-center" />
                    <div v-show="step > 1" class="col-1" />
                    <q-btn class="q-mt-md col flex-center" @click="onContinueStep" color="primary"
                      :label="step === 3 ? ' Cadastrar' : 'Proximo'" />
                  </div>
                </q-stepper-navigation>
              </template>
            </q-stepper>
          </q-form>
        </q-card-section>
      </q-card>
    </div>
  </div>
</template>


<script>
import { defineComponent } from 'vue'
import { date, useQuasar } from 'quasar'
import { ref } from 'vue'
import { gsap } from 'gsap';

let $q

export default defineComponent({
  name: 'SignUp',
  setup() {
    const fieldRefPass = ref(null)
    const fieldRefRePass = ref(null)
    const fieldEmail = ref(null)
    const fieldCPF = ref(null)
    const fieldDataNasc = ref(null)
    const stepperRef = ref(null)
    return {
      fieldUsername: ref(null),
      isPwd: ref(true),
      isPwd2: ref(true),
      step: ref(1),
      aceiteEULA: ref(false),
    }
  },
  computed: {
    UsernameValidation() {
      return [
        (v) => !!v || "O nome de usuário não pode estar vazio.",
      ]
    },
    PasswordValidation() {
      return [
        (v) => !!v || "A senha não pode estar vazia.",
        (v) => v.length > 6 || "A senha deve conter 6 caracteres ou mais",
      ]
    },
    RePasswordValidation() {
      return [
        (v) => !!v || "A senha não pode estar vazia.",
        (v) => v.length > 6 || "A senha deve conter 6 caracteres ou mais",
        (v) => v == this.login.password || "As duas senhas devem ser iguais"
      ]
    },
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
    validarCPF() {

      return (CPF) => {
        if (typeof CPF !== 'string') {
          return false; // Retorna falso se não for uma string
        }
        // return true

        // Verifica se todos os dígitos do CPF são iguais
        if (/^(\d)\1{10}$/.test(CPF)) {
          return false;
        }

        var soma = 0;
        var i;
        var resto;

        if (CPF == "00000000000") return false;
        if (CPF.length != 11) return false;

        for (i = 1; i <= 9; i++)
          soma = soma + parseInt(CPF.substring(i - 1, i)) * (11 - i);
        resto = (soma * 10) % 11;

        if (resto == 10 || resto == 11) resto = 0;
        if (resto != parseInt(CPF.substring(9, 10))) return false;

        soma = 0;
        for (i = 1; i <= 10; i++)
          soma = soma + parseInt(CPF.substring(i - 1, i)) * (12 - i);
        resto = (soma * 10) % 11;

        if (resto == 10 || resto == 11) resto = 0;
        if (resto != parseInt(CPF.substring(10, 11))) return false;
        return true;
      }
    },

    validDateBr() {

      return (dateStr) => {
        if (typeof dateStr !== 'string') {
          return false;
        }
        // return true

        const re = /^(\d{2})\/(\d{2})\/(\d{4})$/;

        const match = dateStr.match(re);

        if (!match) {
          return false;
        }

        const day = parseInt(match[1], 10);
        const month = parseInt(match[2], 10);
        const year = parseInt(match[3], 10);

        if (month < 1 || month > 12 || day < 1 || day > new Date(year, month, 0).getDate()) {
          return false;
        }

        return true;
      };
    },
    transformDateToISO() {
      return (dateStr) => {
        if (typeof dateStr !== 'string') {
          return false;
        }
        const parts = dateStr.split('/');
        if (parts.length === 3) {
          const day = parts[0];
          const month = parts[1];
          const year = parts[2];

          const formattedDate = `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}`;

          return formattedDate;
        }

        return null;
      }
    },

  },
  data() {
    return {
      login: {
        username: '',
        password: '',
        repassword: '',
        email: '',
        CPF: '',
        dataNasc: '',
      }
    }
  },

  methods: {
    onContinueStep() {
      switch (this.step) {
        case 1:
          this.$refs.fieldUsername.validate()
          this.$refs.fieldRefPass.validate()
          this.$refs.fieldRefRePass.validate()
          if (!this.$refs.fieldUsername.hasError
            && !this.$refs.fieldRefPass.hasError
            && !this.$refs.fieldRefRePass.hasError) {
            this.$refs.Stepper.next();
          }
          break;
        case 2:
          this.$refs.fieldCPF.validate()
          this.$refs.fieldEmail.validate()
          this.$refs.fieldDataNasc.validate()
          if (!this.$refs.fieldCPF.hasError
            && !this.$refs.fieldEmail.hasError
            && !this.$refs.fieldDataNasc.hasError) {
            this.$refs.Stepper.next();
          }
          break;
        default:
          if (this.aceiteEULA == true) {
            $q.notify({
              type: 'positive',
              message: `nome: ${this.login.username}, senha: ${this.login.password}, email: ${this.login.email}, dataNascimento: ${this.transformDateToISO(this.login.dataNasc)
                }, CPF: ${this.login.CPF}`,
              multiLine: true,
            })
          }
          break;
      }
    },
    btntest(a) {
      console.log(validarCPF(a));

    }
  },
  mounted() {
    $q = useQuasar();
    gsap.from(".geral", {
      xPercent: 100,
    })
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

.teste1 {
  background-color: rgba(0, 0, 0, 0.253);
}

.geral {
  position: relative;
  overflow: hidden;
}
</style>
