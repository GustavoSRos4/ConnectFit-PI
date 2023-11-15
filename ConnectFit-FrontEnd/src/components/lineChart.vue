<template>
  <div>
    <Line1 ref="myChart" :data="chartData" :options="options" />
  </div>
</template>

<script>
import { Line as Line1 } from 'vue-chartjs'
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
} from 'chart.js'

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
)

export default {
  name: 'lineChart',
  components: {
    Line1
  },
  props: ['chartData', 'chartOptions'],

  data() {
    return {
      options: {
        scales: {
          x: {
            grid: {
              color: 'rgba(255, 255, 255, 0.1)', // Cor da grade no eixo X
            },
          },
          y: {
            grid: {
              color: 'rgba(255, 255, 255, 0.1)', // Cor da grade no eixo Y
            },
          },
        },
        type: 'line',
        responsive: true,
        maintainAspectRatio: true,
        pointBorderColor: "transparent",
        borderColor: 'rgba(255, 255, 255, 0.7)',
        borderWidth: 1,

      },
    }
  },
};
</script>
