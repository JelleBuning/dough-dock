import 'package:dough_dock/ui/dough/view_model/dough_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Doses extends StatelessWidget {
  const Doses({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DoughViewModel>();

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Doses', style: Theme.of(context).textTheme.bodyLarge),
        Row(
          spacing: 10,
          children: [
            Expanded(child: _DoseCard(title: 'Flour', amount: viewModel.getTotalFlour(), unit: 'g')),
            Expanded(child: _DoseCard(title: 'Water', amount: viewModel.getTotalWater(), unit: 'g')),
          ],
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: _DoseCard(
                title: 'Salt',
                amount: viewModel.getTotalSalt(),
                unit: 'g',
                behindComma: 1,
              ),
            ),
            Expanded(
              child: _DoseCard(
                title: 'Yeast',
                amount: viewModel.getTotalYeast(),
                unit: 'g',
                behindComma: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DoseCard extends StatelessWidget {
  const _DoseCard({
    required this.title,
    required this.amount,
    required this.unit,
    this.behindComma = 0,
  });

  final String title;
  final double amount;
  final String unit;
  final int behindComma;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              Text(
                '${amount.toStringAsFixed(behindComma)} $unit',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
