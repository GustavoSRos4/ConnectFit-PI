// src/boot/quasar.js
import { boot } from 'quasar/wrappers';
import httpProxyMiddleware from './httpProxyMiddleware';

export default boot(({ app }) => {
  httpProxyMiddleware(app); // Chame a função de configuração do middleware
});
