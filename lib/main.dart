import 'package:flutter/material.dart';

import 'paginas/pagina_inicial.dart';

void main() {
  runApp(const AplicativoComparadorInvestimentos());
}

class AplicativoComparadorInvestimentos extends StatelessWidget {
  const AplicativoComparadorInvestimentos({super.key});

  @override
  Widget build(BuildContext context) {
    final esquemaCores = ColorScheme.fromSeed(
      seedColor: const Color(0xFF176B87),
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'QualRende+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: esquemaCores,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F7F9),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFDCE5E9)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: esquemaCores.primary, width: 2),
          ),
        ),
      ),
      home: const PaginaInicial(),
    );
  }
}
