import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:calculadora_investimentos/main.dart';

void main() {
  testWidgets('simula dois investimentos e exibe os resultados', (
    tester,
  ) async {
    await tester.pumpWidget(const AplicativoComparadorInvestimentos());

    expect(find.text('Comparador de investimentos'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('campo-meses')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.enterText(find.byKey(const ValueKey('campo-meses')), '12');
    await tester.tap(find.byIcon(Icons.insights_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Resultado da simulação'), findsOneWidget);
    expect(find.text('Montante final'), findsOneWidget);
    expect(
      find.text('Comparação visual dos resultados ao final do período.'),
      findsOneWidget,
    );
    expect(find.text('Investimento A'), findsWidgets);
    expect(find.text('Investimento B'), findsWidgets);
    await tester.scrollUntilVisible(
      find.text('Evolução mensal'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Evolução mensal'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Nova comparação'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Nova comparação'), findsOneWidget);
    await tester.tap(find.text('Nova comparação'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Descubra qual rende mais'),
      -300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Descubra qual rende mais'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Iniciar simulação'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Iniciar simulação'), findsOneWidget);
  });
}
