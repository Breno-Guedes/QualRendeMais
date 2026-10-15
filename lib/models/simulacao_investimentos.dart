class EntradaInvestimento {
  const EntradaInvestimento({
    required this.nome,
    required this.capitalInicial,
    required this.aporteMensal,
    required this.taxaMensal,
  });

  final String nome;
  final double capitalInicial;
  final double aporteMensal;
  final double taxaMensal;
}

class SaldoMensal {
  const SaldoMensal({
    required this.mes,
    required this.totalInvestido,
    required this.rendimento,
    required this.saldo,
  });

  final int mes;
  final double totalInvestido;
  final double rendimento;
  final double saldo;
}

class ResultadoInvestimento {
  const ResultadoInvestimento({
    required this.entrada,
    required this.saldosMensais,
  });

  final EntradaInvestimento entrada;
  final List<SaldoMensal> saldosMensais;

  SaldoMensal get saldoFinal => saldosMensais.last;
  double get totalInvestido => saldoFinal.totalInvestido;
  double get rendimentoAcumulado => saldoFinal.rendimento;
  double get montanteFinal => saldoFinal.saldo;
}

ResultadoInvestimento simularInvestimento(
  EntradaInvestimento entrada,
  int meses,
) {
  var saldo = entrada.capitalInicial;
  // O mês zero representa apenas o capital inicial, antes dos aportes.
  final saldosMensais = <SaldoMensal>[
    SaldoMensal(
      mes: 0,
      totalInvestido: entrada.capitalInicial,
      rendimento: 0,
      saldo: saldo,
    ),
  ];

  // Em cada ciclo, aplica-se o juro sobre o saldo e depois o aporte mensal.
  for (var mes = 1; mes <= meses; mes++) {
    final rendimento = saldo * (entrada.taxaMensal / 100);
    saldo += rendimento + entrada.aporteMensal;
    saldosMensais.add(
      SaldoMensal(
        mes: mes,
        totalInvestido: entrada.capitalInicial + entrada.aporteMensal * mes,
        rendimento:
            saldo - (entrada.capitalInicial + entrada.aporteMensal * mes),
        saldo: saldo,
      ),
    );
  }

  return ResultadoInvestimento(
    entrada: entrada,
    saldosMensais: saldosMensais,
  );
}
