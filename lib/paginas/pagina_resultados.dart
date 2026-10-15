import 'package:flutter/material.dart';

import '../models/simulacao_investimentos.dart';
import '../utils/formatador_moeda.dart';

class PaginaResultados extends StatelessWidget {
  const PaginaResultados({
    super.key,
    required this.resultadoA,
    required this.resultadoB,
  });

  final ResultadoInvestimento resultadoA;
  final ResultadoInvestimento resultadoB;

  @override
  Widget build(BuildContext context) {
    final vencedor = resultadoA.montanteFinal >= resultadoB.montanteFinal
        ? resultadoA
        : resultadoB;
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado da simulação')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  const Icon(
                    Icons.emoji_events_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      '${vencedor.entrada.nome} teve o maior montante final.',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _CartaoResumo(
                  resultado: resultadoA,
                  cor: const Color(0xFF176B87),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _CartaoResumo(
                  resultado: resultadoB,
                  cor: const Color(0xFFE07A5F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _GraficoComparativo(resultadoA: resultadoA, resultadoB: resultadoB),
          const SizedBox(height: 24),
          Text(
            'Evolução mensal',
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Container(
                  color: const Color(0xFFEAF1F4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 42,
                        child: Text(
                          'Mês',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Invest. A',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Invest. B',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                ...List.generate(resultadoA.saldosMensais.length, (indice) {
                  final saldoA = resultadoA.saldosMensais[indice];
                  final saldoB = resultadoB.saldosMensais[indice];
                  return ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      radius: 15,
                      child: Text(
                        '${saldoA.mes}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            formatarMoeda(saldoA.saldo),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            formatarMoeda(saldoB.saldo),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.refresh),
            label: const Text('Nova comparação'),
          ),
        ],
      ),
    );
  }
}

class _GraficoComparativo extends StatelessWidget {
  const _GraficoComparativo({
    required this.resultadoA,
    required this.resultadoB,
  });

  final ResultadoInvestimento resultadoA;
  final ResultadoInvestimento resultadoB;

  @override
  Widget build(BuildContext context) {
    // A maior barra representa 100%; a outra é proporcional a ela.
    final maiorMontante = resultadoA.montanteFinal > resultadoB.montanteFinal
        ? resultadoA.montanteFinal
        : resultadoB.montanteFinal;

    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Montante final',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Comparação visual dos resultados ao final do período.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: _BarraGrafico(
                    rotulo: 'Investimento A',
                    valor: resultadoA.montanteFinal,
                    maiorValor: maiorMontante,
                    cor: const Color(0xFF176B87),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: _BarraGrafico(
                    rotulo: 'Investimento B',
                    valor: resultadoB.montanteFinal,
                    maiorValor: maiorMontante,
                    cor: const Color(0xFFE07A5F),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BarraGrafico extends StatelessWidget {
  const _BarraGrafico({
    required this.rotulo,
    required this.valor,
    required this.maiorValor,
    required this.cor,
  });

  final String rotulo;
  final double valor;
  final double maiorValor;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    final proporcao = maiorValor == 0 ? 0.0 : valor / maiorValor;
    return Column(
      children: [
        Text(
          formatarMoeda(valor),
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 130,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: proporcao.clamp(0.05, 1.0),
              widthFactor: 0.55,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: cor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          rotulo,
          textAlign: TextAlign.center,
          style: TextStyle(color: cor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _CartaoResumo extends StatelessWidget {
  const _CartaoResumo({required this.resultado, required this.cor});

  final ResultadoInvestimento resultado;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              resultado.entrada.nome,
              style: TextStyle(color: cor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              formatarMoeda(resultado.montanteFinal),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 10),
            _Metrica(
              rotulo: 'Total investido',
              valor: formatarMoeda(resultado.totalInvestido),
            ),
            _Metrica(
              rotulo: 'Rendimento',
              valor: formatarMoeda(resultado.rendimentoAcumulado),
            ),
          ],
        ),
      ),
    );
  }
}

class _Metrica extends StatelessWidget {
  const _Metrica({required this.rotulo, required this.valor});

  final String rotulo;
  final String valor;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Text('$rotulo\n$valor', style: const TextStyle(fontSize: 11)),
  );
}
