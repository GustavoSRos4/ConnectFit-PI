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
          <q-form class="q-gutter-md" @submit.prevent="submit">
            <q-stepper v-model="step" color="primary" animated ref="Stepper" contracted keep-alive>
              <q-step :name="1" title="Passo 1" :done="step > 1">
                <div class="q-mx-sm">
                  <q-input name="name" ref="fieldUsername" label="Nome Completo" v-model="login.name" lazy-rules
                    :rules="[required]">
                  </q-input>
                  <q-input name="email" ref="fieldEmail" label="Email" v-model="login.email" lazy-rules
                    :rules="[required, validateEmail]">
                  </q-input>
                  <q-input name="password" ref="fieldRefPass" label="Senha" :type="isPwd ? 'password' : 'text'"
                    v-model="login.password" lazy-rules :rules="[required, minLength(6)]">
                    <template v-slot:append>
                      <q-icon :name="isPwd ? 'visibility' : 'visibility_off'" class="cursor-pointer"
                        @click="isPwd = !isPwd"></q-icon>
                    </template>
                  </q-input>
                  <q-input ref="fieldRefRePass" label="Repetir Senha" :type="isPwd2 ? 'password' : 'text'"
                    v-model="login.repassword" :rules="[required, minLength(6), confirmPassword(login.password)]"
                    lazy-rules>
                    <template v-slot:append>
                      <q-icon :name="isPwd2 ? 'visibility' : 'visibility_off'" class="cursor-pointer"
                        @click="isPwd2 = !isPwd2"></q-icon>
                    </template>
                  </q-input>
                </div>
              </q-step>

              <q-step :name="2" title="Passo 2" :done="step > 2">
                <div class="q-mx-sm">
                  <q-input name="CPF" ref="fieldCPF" label="CPF" v-model="login.CPF" lazy-rules unmasked-value
                    mask="###.###.###-##" @input="login.CPF = parseInt(login.CPF)" :rules="[validarCPF]"></q-input>

                  <q-input name="Telefone" ref="fieldTelefone" label="Telefone" v-model="login.telefone" lazy-rules
                    unmasked-value :mask="login.telefone.length > 10 ? '(##) #####-####' : '(##) ####-#####'"
                    :rules="[required, minLength(10)]"></q-input>

                  <q-input label="Data de Nascimento" name="dataNasc" v-model="login.dataNasc" mask="##/##/####"
                    ref="fieldDataNasc" :rules="[required, validateDateBrasil]">
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
                  <q-select ref="fieldSexo" label="Sexo" filled v-model="login.sexo" :options="option"
                    option-value="Sigla" option-label="Descricao" option-disable="inactive" emit-value map-options
                    style="min-width: 250px;" :rules="[required]" />

                </div>
              </q-step>
              <q-step :name="3" title="Passo 3" :done="step > 3">
                <div class="q-mx-sm">
                  <q-input name="CEP" mask="#####-###" ref="fieldCEP" label="CEP" v-model="login.CEP" unmasked-value
                    lazy-rules :rules="[required]" @change="fetchAddress">
                  </q-input>

                  <q-select ref="fieldUF" v-model="login.uf" use-input input-debounce="500" option-value="SiglaUF"
                    option-label="Descricao" label="UF" :options="ufFilter" @filter="filterFnUF"
                    @update:model-value="fetchCities" :rules="[required]">
                    <template v-slot:no-option>
                      <q-item>
                        <q-item-section class="text-grey">
                          No results
                        </q-item-section>
                      </q-item>
                    </template>
                  </q-select>

                  <q-select class="q-mt-md" ref="fieldCidade" :disable="login.uf ? false : true" filled
                    v-model="login.cidade" use-input input-debounce="0" option-value="idCidade" option-label="NomeCidade"
                    label="Cidade" :options="cidadesFilter" @filter="filterFnCidade" :rules="[required]">
                    <template v-slot:no-option>
                      <q-item>
                        <q-item-section class="text-grey">
                          No results
                        </q-item-section>
                      </q-item>
                    </template>
                  </q-select>

                  <q-input name="Logradouro" ref="fieldLogradouro" label="Logradouro" v-model="login.logradouro"
                    lazy-rules :rules="[required]">
                  </q-input>

                  <q-input name="Bairro" ref="fieldBairro" label="Bairro" v-model="login.bairro" lazy-rules
                    :rules="[required]">
                  </q-input>

                  <q-input name="Numero" ref="fieldNumero" label="Número" v-model="login.numero" lazy-rules
                    :rules="[required]">
                  </q-input>

                  <q-input name="Complemento" ref="fieldComplemento" label="Complemento" v-model="login.complemento"
                    lazy-rules>
                  </q-input>

                </div>
              </q-step>

              <q-step :name="4" title="Passo 4" :done="step > 4">
                <q-input name="numRegistro" ref="fieldNumRegistro" label="Número de Registro" v-model="login.numRegistro"
                  lazy-rules :rules="[required]">
                </q-input>

                <q-input label="Data de Formação" name="dataFormacao" v-model="login.dataFormacao" mask="##/##/####"
                  ref="fieldDataFormacao" :rules="[required, validateDateBrasil]">
                  <template v-slot:append>
                    <q-icon name="event" class="cursor-pointer">
                      <q-popup-proxy cover transition-show="scale" transition-hide="scale">
                        <q-date v-model="login.dataFormacao" calendar="gregorian" mask="DD/MM/YYYY">
                          <div class="row items-center justify-end">
                            <q-btn v-close-popup label="Close" color="primary" flat />
                          </div>
                        </q-date>
                      </q-popup-proxy>
                    </q-icon>
                  </template>
                </q-input>

                <q-input name="valor" ref="fieldValor" label="Honorário serviços" v-model="login.valor" lazy-rules
                  prefix="R$" :rules="[required, validateValor]" type="number">
                </q-input>

                <q-select label="Especialidades" v-model="login.especialidade" use-input use-chips multiple
                  hide-dropdown-icon input-debounce="0" @new-value="createValue" option-label="descricao"
                  :rules="[required]" ref="fieldEspecialidade">
                  <template v-slot:append>
                    <q-icon name="info">
                      <q-tooltip transition-show="scale" transition-hide="scale">
                        Para adicionar especialidades, insira o nome e pressione a tecla "Enter".
                      </q-tooltip>
                    </q-icon>
                  </template>
                </q-select>
              </q-step>

              <q-step :name="5" title="Passo 5" :done="step > 5">
                <q-scroll-area style="height: 300px;">
                  <p>TERMOS DE LICENÇA DO USUÁRIO FINAL (EULA) - CONNECTIONFIT</p>

                  <p> Este Termo de Licença do Usuário Final ("EULA") é um acordo legal entre você (doravante referido
                    como
                    "Usuário") e [Nome da Empresa] (doravante referida como "ConnectionFit"). Este EULA regula o uso
                    do
                    aplicativo móvel ConnectionFit e quaisquer serviços relacionados (doravante referidos como
                    "Aplicativo").</p>

                  <ul>
                    <li>1. Aceitação dos Termos

                      Ao instalar, acessar ou usar o Aplicativo, o Usuário concorda com os termos e condições deste
                      EULA.
                      Se
                      o
                      Usuário não concordar com estes termos, não deverá usar o Aplicativo.
                    </li>
                    <li>
                      2. Dados Pessoais e de Saúde

                      O Aplicativo pode coletar e armazenar dados pessoais e de saúde do Usuário, incluindo, mas não
                      se
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
                      Os dados do Usuário serão armazenados de forma segura e serão acessíveis apenas para fins
                      internos
                      da
                      ConnectionFit. Não compartilharemos seus dados com terceiros sem seu consentimento explícito.
                    </li>
                    <li>
                      4. Consentimento Informado

                      O Usuário concorda em fornecer informações precisas e atualizadas. O Usuário também compreende
                      que o
                      uso
                      do Aplicativo é de sua própria responsabilidade e que a ConnectionFit não assume
                      responsabilidade
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

                      A ConnectionFit se reserva o direito de encerrar a conta do Usuário e excluir seus dados a
                      qualquer
                      momento, se o Usuário violar este EULA ou se a empresa decidir encerrar o Aplicativo.
                    </li>
                    <li>
                      7. Alterações nos Termos

                      A ConnectionFit se reserva o direito de modificar este EULA a qualquer momento. As alterações
                      entrarão
                      em
                      vigor após a publicação das versões atualizadas no Aplicativo. O uso contínuo do Aplicativo após
                      a
                      modificação será considerado como aceitação das alterações.
                    </li>
                    <li>
                      8. Contato

                      Para entrar em contato com a ConnectionFit ou fazer perguntas sobre este EULA, envie um email
                      para
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
                      :label="step === 5 ? ' Cadastrar' : 'Proximo'" />
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
import { defineComponent, ref } from 'vue';
import { useQuasar } from 'quasar';
import { gsap } from 'gsap';
import axios from 'axios';
import { useRouter } from 'vue-router';
import { api } from 'src/boot/axios';
import { Loading } from 'quasar'
import { validarCPF, required, minLength, confirmPassword, validateEmail, validateDateBrasil, validateValor } from '../utils/validar';

const router = useRouter();

export default defineComponent({
  name: 'SignUp',
  setup() {
    const $q = useQuasar()
    const fieldRefPass = ref(null)
    const fieldRefRePass = ref(null)
    const fieldEmail = ref(null)
    const fieldCPF = ref(null)
    const fieldDataNasc = ref(null)
    const fieldCEP = ref(null)
    const stepperRef = ref(null)
    return {
      fieldUsername: ref(null),
      isPwd: ref(true),
      isPwd2: ref(true),
      step: ref(1),
      aceiteEULA: ref(false),
      createValue(val, done) {
        done({ descricao: val })
      }
    }
  },
  computed: {
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

          const formattedDate = `${year}/${month.padStart(2, '0')}/${day.padStart(2, '0')}`;

          return formattedDate;
        }

        return null;
      }
    },
  },

  data() {
    return {
      sucess: false,
      option: [],
      ufs: [],
      ufFilter: [],
      cidades: [],
      cidadesFilter: [],
      login: {
        name: '',
        password: '',
        repassword: '',
        email: '',
        CPF: '',
        dataNasc: '',
        sexo: ref(null),
        CEP: '',
        uf: '',
        cidade: '',
        logradouro: '',
        bairro: '',
        numero: '',
        complemento: '',
        telefone: '',
        numRegistro: '',
        dataFormacao: '',
        valor: ref(null),
        especialidade: [],
      }
    }
  },
  methods: {
    required,
    minLength,
    confirmPassword,
    validateEmail,
    validarCPF,
    validateDateBrasil,
    validateValor,


    filterFnUF(val, update, abort) {
      update(() => {
        const serch = val.toLowerCase();
        this.ufFilter = this.ufs.filter(v => v && v.Descricao && v.Descricao.toLowerCase().indexOf(serch) > -1);
      });
    },

    filterFnCidade(val, update, abort) {
      update(() => {
        const serch = val.toLowerCase();
        this.cidadesFilter = this.cidades.filter(v => v && v.NomeCidade && v.NomeCidade.toLowerCase().indexOf(serch) > -1);
      });
    },

    async fetchUF(tentativasRestantes) {
      try {
        const response = await api.get('api/ufSexo');
        this.ufs = response.data.Uf
        this.ufFilter = response.data.Uf
        this.option = response.data.Sexo
        console.log(response);
      } catch (error) {
        if (tentativasRestantes > 0) {
          console.error(`Erro na tentativa. Tentativas restantes: ${tentativasRestantes}`);
          await new Promise((resolve) => setTimeout(resolve, 1000)); // Espera 1 segundo entre as tentativas
          await fetchUF(tentativasRestantes - 1); // Tenta novamente com uma tentativa a menos
        } else {
          this.$q.notify({
            type: 'negative',
            message: `Falha após 10 tentativas. Por favor, tente novamente mais tarde.`,
          });
          console.error('Falha após 10 tentativas.');
        }
      }
    },

    fetchCities() {
      this.login.cidade = "";
      api
        .get(`api/${this.login.uf.SiglaUF}/cidades`)
        .then(response => {
          this.cidades = response.data.Cidades
          this.cidadesFilter = response.data.Uf
        })
        .catch(error => {
          console.error('Houve um erro ao buscar as UFs', error);
        });
    },

    fetchAddress() {
      axios
        .get(`https://viacep.com.br/ws/${this.login.CEP}/json/`)
        .then(response => {
          const data = response.data;
          this.login.logradouro = data.logradouro;
          this.login.bairro = data.bairro;
        })
        .catch(error => {
          console.error('Houve um erro ao buscar o endereço', error);
        });
    },
    async onContinueStep() {
      switch (this.step) {
        case 1:

          var inputs = {
            name: this.login.name,
            email: this.login.email,
            password: this.login.password,
            password_confirmation: this.login.repassword,
          };

          this.$refs.fieldUsername.validate()
          this.$refs.fieldEmail.validate()
          this.$refs.fieldRefPass.validate()
          this.$refs.fieldRefRePass.validate()
          if (!this.$refs.fieldUsername.hasError
            && !this.$refs.fieldRefPass.hasError
            && !this.$refs.fieldEmail.hasError
            && !this.$refs.fieldRefRePass.hasError) {

            await api.post('api/registrarUsuario', inputs).then(response => {
              const token = response.data.token
              localStorage.setItem('token', token);
              //Forcando token na header, pois esta ocasionando erros
              axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
              //Chama o fetchda uf e sexos
              this.fetchUF(10);
              this.$refs.Stepper.next()
            }).catch(response => {
              this.$q.notify({
                type: 'negative',
                message: `${response.response.data.errors}`,
              })
              console.error(response.response.data.errors);
            });
          }
          break;
        case 2:
          this.$refs.fieldCPF.validate()
          this.$refs.fieldSexo.validate()
          this.$refs.fieldDataNasc.validate()
          this.$refs.fieldTelefone.validate()
          if (!this.$refs.fieldCPF.hasError
            && !this.$refs.fieldDataNasc.hasError
            && !this.$refs.fieldSexo.hasError
            && !this.$refs.fieldTelefone.hasError) {
            this.$refs.Stepper.next();
          }
          break;
        case 3:
          this.$refs.fieldCEP.validate()
          this.$refs.fieldUF.validate()
          this.$refs.fieldCidade.validate()
          this.$refs.fieldLogradouro.validate()
          this.$refs.fieldBairro.validate()
          this.$refs.fieldNumero.validate()
          if (!this.$refs.fieldCEP.hasError &&
            !this.$refs.fieldUF.hasError &&
            !this.$refs.fieldCidade.hasError &&
            !this.$refs.fieldLogradouro.hasError &&
            !this.$refs.fieldBairro.hasError &&
            !this.$refs.fieldNumero.hasError) {
            var dataPessoa = {
              cpf: parseInt(this.login.CPF),
              dataNas: this.transformDateToISO(this.login.dataNasc),
              ddd: parseInt(this.login.telefone.substring(0, 2)),
              numeroTel: parseInt(this.login.telefone.substring(2)),
              logradouro: this.login.logradouro,
              numeroEnd: this.login.numero,
              cep: this.login.CEP,
              bairro: this.login.bairro,
              idCidade: this.login.cidade.idCidade,
              SiglaSexo: this.login.sexo,
            };

            await api
              .post("api/criarPessoa", dataPessoa)
              .then(res => {
                this.$refs.Stepper.next();
              })
              .catch(err => {
                console.log(err);
                this.$q.notify({
                  type: 'warning',
                  message: `${err.response.data.message}`,
                  caption: `${err.response.data.error}`,
                })
              })
              .finally(() => {
                Loading.hide();
              });
          }
          break;
        case 4:
          this.$refs.fieldNumRegistro.validate();
          this.$refs.fieldDataFormacao.validate();
          this.$refs.fieldValor.validate();
          this.$refs.fieldEspecialidade.validate();
          if (!this.$refs.fieldNumRegistro.hasError &&
            !this.$refs.fieldDataFormacao.hasError &&
            !this.$refs.fieldValor.hasError &&
            !this.$refs.fieldEspecialidade.hasError) {
            this.$refs.Stepper.next();
          }

          break;
        case 5:
          if (!this.aceiteEULA === false) {
            Loading.show({
              message: "Aguarde...",
              spinnerColor: 'primary',
              spinnerSize: 200,
            });

            var dataProfissional = {
              numReg: this.login.numRegistro,
              dataFormacao: this.transformDateToISO(this.login.dataFormacao),
              valor: this.login.valor,
              especialidade: this.login.especialidade
            }
            await api.post('api/createPessoaProfissional', dataProfissional)
              .then(res => {
                this.$q.notify({
                  type: 'positive',
                  message: `${res.data.message}`,
                })
                this.sucess = true;
              })
              .catch(err => {
                console.log(err);
                this.$q.notify({
                  type: 'warning',
                  message: `${err.response.data.message}`,
                })
              })
              .finally(() => {
                Loading.hide();
              });
            if (this.sucess == true) {
              this.$router.push({ name: 'IndexDashboard' });
            }
          } else {
            this.$q.notify({
              type: 'warning',
              message: "Você deve aceitar o EULA para se registrar.",
            })
            Loading.hide()
          }
          break;
      }
    }
  },
  mounted() {
    gsap.from(".geral", {
      xPercent: 100,
    })
  },

});

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
