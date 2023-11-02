//  validação obrigatório
export const required = (value) => {
  if (value === null || value === undefined) {
    return "Este campo é obrigatório";
  }
  if (value.trim() === "") {
    return "Este campo é obrigatório";
  }
  return true;
};
// Validacao tamanho minimo
export const minLength = (length) => {
  return (value) => {
    if (!value || value.length < length) {
      return `Este campo deve ter pelo menos ${length} caracteres`;
    }
    return true;
  };
};
// validacao da confirmacao de senha
export const confirmPassword = (password) => {
  return (value) => {
    if (value !== password) {
      return "As senhas não correspondem";
    }
    return true;
  };
};
// VALIDACAO DE EMAIL aaaa@aaa.aaa
export const validateEmail = (email) => {
  if (typeof email !== "string") {
    return "O email deve ser válido!";
  }

  const re =
    /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  if (re.test(email) == true) {
    return true;
  } else {
    return "O email deve ser válido!";
  }
};
// VALIDACAO DA DATA DE NASCIMENTO, NO FORMATO BRASILEIRO (DD/MM/YYYY)
export const validateDateBrasil = (dateStr) => {
  const invalid = "A data deve ser válida!";
  if (typeof dateStr !== "string") {
    return invalid;
  }
  const re = /^(\d{2})\/(\d{2})\/(\d{4})$/;
  const match = dateStr.match(re);
  if (!match) {
    return invalid;
  }
  const day = parseInt(match[1], 10);
  const month = parseInt(match[2], 10);
  const year = parseInt(match[3], 10);

  if (
    month < 1 ||
    month > 12 ||
    day < 1 ||
    day > new Date(year, month, 0).getDate()
  ) {
    return invalid;
  }
  return true;
};
//Validacao CPF
export const validarCPF = (CPF) => {
  console.log(CPF);
  const invalid = "CPF inválido.";
  if (typeof CPF !== "string") {
    return invalid;
  }
  // return true

  // Verifica se todos os dígitos do CPF são iguais
  if (/^(\d)\1{10}$/.test(CPF)) {
    return invalid;
  }

  var soma = 0;
  var i;
  var resto;

  if (CPF == "00000000000") return invalid;
  if (CPF.length != 11) return invalid;

  for (i = 1; i <= 9; i++)
    soma = soma + parseInt(CPF.substring(i - 1, i)) * (11 - i);
  resto = (soma * 10) % 11;

  if (resto == 10 || resto == 11) resto = 0;
  if (resto != parseInt(CPF.substring(9, 10))) return invalid;

  soma = 0;
  for (i = 1; i <= 10; i++)
    soma = soma + parseInt(CPF.substring(i - 1, i)) * (12 - i);
  resto = (soma * 10) % 11;

  if (resto == 10 || resto == 11) resto = 0;
  if (resto != parseInt(CPF.substring(10, 11))) return invalid;
  return true;
};
