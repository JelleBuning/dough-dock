import 'package:dough_dock/ui/core/models/dough.dart';
import 'package:flutter/material.dart';

class Doses extends StatelessWidget {
  final DoughViewModel dough;

  const Doses({super.key, required this.dough});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Doses', style: Theme.of(context).textTheme.bodyLarge),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: _DoseCard(
                title: 'Flour',
                amount: dough.getTotalFlour(),
                unit: 'g',
              ),
            ),
            Expanded(
              child: _DoseCard(
                title: 'Water',
                amount: dough.getTotalWater(),
                unit: 'g',
              ),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: _DoseCard(
                title: 'Salt',
                amount: dough.getTotalSalt(),
                unit: 'g',
                behindComma: 1,
              ),
            ),
            Expanded(
              child: _DoseCard(
                title: 'Yeast',
                amount: dough.getTotalYeast(),
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
  final String title;
  final double amount;
  final String unit;
  final int behindComma;

  const _DoseCard({
    required this.title,
    required this.amount,
    required this.unit,
    this.behindComma = 0,
  });

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
