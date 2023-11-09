<template>
  <q-parallax class="responsive window-height" :speed="1">
    <template v-slot:media>
      <img src="~assets/background/parallax1.png">
    </template>

    <h3 class="title text-h5 text-uppercase text-weight-regular">Bem-vindo(a) à Jornada de Transformação!</h3>
    <q-btn class="bg-primary" icon-right="send" label="Começar" :to="{ name: 'LoginPage' }" />
    <q-btn class="bg-primary" @click="buscarDados">teste get nome</q-btn>
  </q-parallax>
  <div class="row">
    <div class="col-12 flex flex-center inicioContent">
      <h3> ConnectionFit</h3>
    </div>
    <div class="col-12 flex flex-center">
      <div class="q-mx-xl">
        <p class="text-h6 text-grey-5 text-justify">Somos a conexão que você estava procurando para alcançar seus
          objetivos de
          fitness de forma eficaz e personalizada. Somos a ponte que une você, ao seu treinador perfeito!
        </p>
        <p class="aas text-h6 text-grey-5 text-justify">Sabemos que encontrar o personal trainer ideal pode ser
          desafiador. É
          por isso que
          criamos uma plataforma inovadora, projetada para simplificar essa jornada emocionante. Com apenas alguns
          cliques, você pode acessar uma rede exclusiva de treinadores pessoais altamente qualificados, prontos para
          guiá-lo em sua jornada de transformação.
        </p>
        <!--F imagem scrolldown -->

        <div class="col-8 trigger1">
          <div class="charac">
            <img class="char" src="~assets/Weightlift1.png">
          </div>
        </div>
        <div class="teste text-h4 col-2">
          <p class="text-h5 test text-grey-5 text-justify">Como Funciona?</p>
          <ul class="list1">
            <li class="test text-h6 text-grey-5 text-justify">Seu Perfil Personalizado: Comece criando seu perfil e
              definindo
              seus objetivos de fitness.
              Seja
              qual for o seu
              nível de condicionamento físico, idade ou metas, nós o conectaremos ao personal trainer que melhor atenda às
              suas
              necessidades.</li>

            <li class="test text-h6 text-grey-5 text-justify">Seleção de Treinadores: Explore nossa seleção diversificada
              de
              treinadores pessoais.
              Analise
              seus perfis,
              avaliações e áreas de especialização para encontrar aquele que mais combina com você.</li>

            <li class="test text-h6 text-grey-5 text-justify"> Conexão Direta: Comunique-se diretamente com seu personal
              trainer escolhido. Discuta seus
              objetivos, plano de
              treinamento, horários e qualquer dúvida que você possa ter.</li>

            <li class="test text-h6 text-grey-5 text-justify">Treinamento Personalizado: Comece sua jornada de fitness com
              um
              programa sob medida
              projetado
              pelo seu personal
              trainer. Acompanhe seu progresso, ajuste suas metas e alcance resultados incríveis.</li>
          </ul>
        </div>
      </div>
    </div>



  </div>
</template>

<script>
import { QParallax } from 'quasar';
import { defineComponent, onMounted } from 'vue'
import { gsap } from 'gsap';
import ScrollTrigger from "gsap/ScrollTrigger";
import { SteppedEase } from 'gsap';
import {
  Loading, QSpinnerGears
} from 'quasar'
import { api } from 'src/boot/axios';

gsap.registerPlugin(ScrollTrigger);


export default defineComponent({
  name: 'IndexPage',
  components: { QParallax },
  setup() {
    onMounted(() => {
      //Animar Titulo
      gsap.to(".test", {
        opacity: 1,
        ease: "power1.inOut",
        scrollTrigger: {
          trigger: ".char",
          start: "top",
          end: "+=300",
          scrub: true,
          // markers: true,
        }
      })
      gsap.from('.title, .text', {
        opacity: 0.5,
        duration: 2,
        yoyo: true,
        repeat: -1,
        stagger: 2,
      });
      //Animacao p/ o scroll
      gsap.to(".char", {
        repeat: 0,
        x: -1875,
        stagger: 0.2,
        ease: SteppedEase.config(3),
        scrollTrigger: {
          trigger: ".charac",
          start: "top ",
          end: "=+350",
          pin: true,
          scrub: true,
          // markers: true,
        }
      });
    })
  },
  data() {
    return {
      dados: null,
    };
  },
  methods: {
    async buscarDados() {
      try {
        const response = await api.get('/api/mostrarPessoa'); // Use um caminho relativo
        this.dados = response.data;
        console.log(response.data.data);
      } catch (error) {
        console.error('Erro ao buscar dados:', error);
        // Lide com o erro adequadamente
      }
    },
  },
},
)
</script>

<style scoped>
.charac {
  left: 13rem;
  width: 623px;
  height: 623px;
  overflow: hidden;
}

.test {
  opacity: 0;
}

.list1 {
  list-style: decimal;
}
</style>
