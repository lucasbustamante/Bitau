class AuthService {
  // Lista de pares agência-conta permitidos
  static List<String> allowedAccounts = [
    '8499-16924-4', // Agência e conta de Lucas Bustamante
    '1234-56789-9'  // Agência e conta de Bruna Olivatto
    // Adicione mais pares agência-conta conforme necessário
  ];

  // Função para validar o login com base na agência e conta
  static bool validateLogin(String agencia, String conta) {
    // Concatenar agência e conta para formar o par agência-conta fornecido
    String inputPair = '$agencia-$conta';

    // Verificar se o par agência-conta fornecido está na lista de permitidos
    if (allowedAccounts.contains(inputPair)) {
      return true; // Login válido se o par agência-conta estiver na lista permitida
    }

    return false; // Caso contrário, login inválido
  }
}
