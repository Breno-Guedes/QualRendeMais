import 'package:flutter/material.dart';

import '../models/simulacao_investimentos.dart';
import '../utils/formatador_moeda.dart';
import '../widgets/secao_formulario_investimento.dart';
import 'pagina_resultados.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _EstadoPaginaInicial();
}

class _EstadoPaginaInicial extends State<PaginaInicial> {
  final _chaveFormulario = GlobalKey<FormState>();
  bool _estaSimulando = false;
  final _controladorMeses = TextEditingController();
  final _controladorCapitalA = TextEditingController(text: '1000');
  final _controladorAporteA = TextEditingController(text: '200');
  final _controladorTaxaA = TextEditingController(text: '1');
  final _controladorCapitalB = TextEditingController(text: '1000');
  final _controladorAporteB = TextEditingController(text: '200');
  final _controladorTaxaB = TextEditingController(text: '0.8');

  @override
  void dispose() {
    for (final controller in [
      _controladorMeses,
      _controladorCapitalA,
      _controladorAporteA,
      _controladorTaxaA,
      _controladorCapitalB,
      _controladorAporteB,
      _controladorTaxaB,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _simular() {
    if (!_chaveFormulario.currentState!.validate()) return;
    final meses = int.tryParse(_controladorMeses.text);
    if (meses == null || meses < 1 || meses > 600) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Informe um período entre 1 e 600 meses.'),
        ),
      );
      return;
    }

    final resultadoA = simularInvestimento(
      EntradaInvestimento(
        nome: 'Investimento A',
        capitalInicial: converterNumero(_controladorCapitalA.text)!,
        aporteMensal: converterNumero(_controladorAporteA.text)!,
        taxaMensal: converterNumero(_controladorTaxaA.text)!,
      ),
      meses,
    );
    final resultadoB = simularInvestimento(
      EntradaInvestimento(
        nome: 'Investimento B',
        capitalInicial: converterNumero(_controladorCapitalB.text)!,
        aporteMensal: converterNumero(_controladorAporteB.text)!,
        taxaMensal: converterNumero(_controladorTaxaB.text)!,
      ),
      meses,
    );

    setState(() => _estaSimulando = true);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaginaResultados(resultadoA: resultadoA, resultadoB: resultadoB),
      ),
    ).then((_) {
      if (mounted) {
        setState(() => _estaSimulando = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QualRende+'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Form(
          key: _chaveFormulario,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            children: [
              Text(
                'Preencha os dados e compare a evolução de dois investimentos.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              SecaoFormularioInvestimento(
                titulo: 'Investimento A',
                cor: const Color(0xFF176B87),
                controladorCapital: _controladorCapitalA,
                controladorAporte: _controladorAporteA,
                controladorTaxa: _controladorTaxaA,
              ),
              const SizedBox(height: 14),
              SecaoFormularioInvestimento(
                titulo: 'Investimento B',
                cor: const Color(0xFFE07A5F),
                controladorCapital: _controladorCapitalB,
                controladorAporte: _controladorAporteB,
                controladorTaxa: _controladorTaxaB,
              ),
              const SizedBox(height: 14),
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: TextFormField(
                    key: const ValueKey('campo-meses'),
                    controller: _controladorMeses,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Período da simulação',
                      suffixText: 'meses',
                    ),
                    validator: (value) {
                      final meses = int.tryParse(value ?? '');
                      if (meses == null || meses < 1 || meses > 600) {
                        return 'Use um período entre 1 e 600 meses';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 22),
              FilledButton.icon(
                onPressed: _simular,
                icon: _estaSimulando
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.insights_outlined),
                label: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    _estaSimulando
                        ? 'Abrindo resultados...'
                        : 'Iniciar simulação',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
