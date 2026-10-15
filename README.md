# QualRende+

Aplicativo Flutter didático para comparar dois investimentos com juros compostos e aportes mensais.

## Funcionalidades

- Formulário para capital inicial, aporte mensal e juros mensais de cada investimento.
- Período compartilhado de 1 a 600 meses com validação.
- Simulação mês a mês, considerando juros sobre o saldo e aporte ao final de cada mês.
- Resumo com montante final, total investido e rendimento acumulado.
- Comparação lado a lado e lista completa da evolução mensal em reais brasileiros.
- Destaque automático para o investimento com maior montante.
- Gráfico de barras comparando visualmente os montantes finais.
- Botão para reiniciar a simulação e iniciar uma nova comparação.

## Como executar

Na pasta do projeto:

```bash
flutter pub get
flutter run
```

Para validar o projeto:

```bash
flutter analyze
flutter test
```

O projeto mantém a estrutura padrão multiplataforma gerada pelo Flutter. A tela inicial usa `Form`, `TextFormField` e `setState`/navegação com `Navigator`; os resultados usam `ListView` para que simulações longas permaneçam responsivas.
