import { boot } from "quasar/wrappers";
import axios from "axios";

const api = axios.create({ baseURL: "http://127.0.0.1:8000" });

const atualizarToken = (token) => {
  api.defaults.headers.common["Authorization"] = `Bearer ${token}`;
  console.log("funcaoAtualizar");
};

api.interceptors.request.use(
  async (config) => {
    const newToken = localStorage.getItem("token");
    if (newToken) {
      await atualizarToken(newToken);
    }
    console.log("atualizado!");
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

export default boot(({ app }) => {
  app.config.globalProperties.$axios = axios;
  app.config.globalProperties.$api = api;
});

export { api };
