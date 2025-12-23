import 'package:flutter/material.dart';

enum Preferment { poolish, biga }

class PrefermentationType extends StatefulWidget {
  final Preferment initialPreferment;
  final ValueChanged<Preferment> onPrefermentChanged;

  const PrefermentationType({
    super.key,
    this.initialPreferment = Preferment.poolish,
    required this.onPrefermentChanged,
  });

  @override
  State<PrefermentationType> createState() => _PrefermentationTypeState();
}

class _PrefermentationTypeState extends State<PrefermentationType> {
  late Preferment _selectedPreferment;

  @override
  void initState() {
    super.initState();
    _selectedPreferment = widget.initialPreferment;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Preferment', style: Theme.of(context).textTheme.bodyLarge),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: _PrefermentRadioCard(
                title: 'Poolish',
                isSelected: _selectedPreferment == Preferment.poolish,
                onSelected: () {
                  setState(() {
                    _selectedPreferment = Preferment.poolish;
                  });
                  widget.onPrefermentChanged(_selectedPreferment);
                },
              ),
            ),
            Expanded(
              child: _PrefermentRadioCard(
                title: 'Biga',
                isSelected: _selectedPreferment == Preferment.biga,
                onSelected: () {
                  setState(() {
                    _selectedPreferment = Preferment.biga;
                  });
                  widget.onPrefermentChanged(_selectedPreferment);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PrefermentRadioCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onSelected;

  const _PrefermentRadioCard({
    required this.title,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          isSelected ? Theme.of(context).colorScheme.secondaryContainer : null,
      child: InkWell(
        onTap: onSelected,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Radio(
                value: true,
                groupValue: isSelected,
                onChanged: (value) {
                  onSelected();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
