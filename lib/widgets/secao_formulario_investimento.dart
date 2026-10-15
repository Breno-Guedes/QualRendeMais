import 'package:flutter/material.dart';

class SecaoFormularioInvestimento extends StatelessWidget {
  const SecaoFormularioInvestimento({
    super.key,
    required this.titulo,
    required this.cor,
    required this.controladorCapital,
    required this.controladorAporte,
    required this.controladorTaxa,
  });

  final String titulo;
  final Color cor;
  final TextEditingController controladorCapital;
  final TextEditingController controladorAporte;
  final TextEditingController controladorTaxa;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: cor.withValues(alpha: 0.12),
                  child: Icon(Icons.account_balance_wallet_outlined, color: cor),
                ),
                const SizedBox(width: 10),
                Text(
                  titulo,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controladorCapital,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Capital inicial',
                prefixText: r'R$ ',
              ),
              validator: (value) =>
                  _validarValor(value, 'Informe o capital inicial'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: controladorAporte,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Aporte mensal',
                prefixText: r'R$ ',
              ),
              validator: (value) =>
                  _validarValor(value, 'Informe o aporte mensal'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: controladorTaxa,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Juros mensais',
                suffixText: '%',
              ),
              validator: (value) {
                final numero = double.tryParse((value ?? '').replaceAll(',', '.'));
                if (numero == null || numero < 0) {
                  return 'Informe uma taxa válida';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  String? _validarValor(String? value, String mensagem) {
    final numero = double.tryParse((value ?? '').replaceAll(',', '.'));
    if (numero == null || numero < 0) return mensagem;
    return null;
  }
}
