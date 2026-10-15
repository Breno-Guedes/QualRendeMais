String formatarMoeda(double valor) {
  final fixo = valor.toStringAsFixed(2);
  final partes = fixo.split('.');
  final parteInteira = partes[0];
  final sinal = parteInteira.startsWith('-') ? '-' : '';
  final digitos = sinal.isEmpty ? parteInteira : parteInteira.substring(1);
  final agrupado = digitos.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match.group(1)}.',
  );
  return 'R\$ $sinal$agrupado,${partes[1]}';
}

double? converterNumero(String texto) {
  final normalizado = texto.trim().replaceAll('.', '').replaceAll(',', '.');
  return double.tryParse(normalizado);
}
