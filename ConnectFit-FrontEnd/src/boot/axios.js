import { boot } from "quasar/wrappers";
import axios from "axios";

const api = axios.create({ baseURL: "http://127.0.0.1:8000" });

const atualizarToken = (token) => {
  api.defaults.headers.common["Authorization"] = `Bearer ${token}`;
};

api.interceptors.request.use(
  (config) => {
    const newToken = localStorage.getItem("token");
    if (newToken) {
      atualizarToken(newToken);
    }
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
