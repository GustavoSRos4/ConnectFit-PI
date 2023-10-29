// src/boot/httpProxyMiddleware.js
const { createProxyMiddleware } = require('http-proxy-middleware');

module.exports = function (app) {
  app.use(
    createProxyMiddleware('/mostrarTudo', {
      target: 'http://127.0.0.1:8000', // Ajuste para a URL do seu servidor Laravel
      changeOrigin: true,
    })
  );
};
