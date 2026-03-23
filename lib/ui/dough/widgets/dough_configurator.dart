import 'package:dough_dock/core/enumerations/yeast_type.dart';
import 'package:dough_dock/ui/dough/view_model/dough_view_model.dart';
import 'package:dough_dock/ui/dough/models/yeast.dart';
import 'package:flutter/material.dart';

class DoughConfigurator extends StatefulWidget {
  final DoughViewModel viewModel;

  const DoughConfigurator({super.key, required this.viewModel});

  @override
  State<DoughConfigurator> createState() => _DoughConfiguratorState();
}

class _DoughConfiguratorState extends State<DoughConfigurator> {
  List<Yeast> yeasts = <Yeast>[
    Yeast(name: 'Fresh', selected: true),
    Yeast(name: 'Dry'),
    Yeast(name: 'Sourdough'),
  ];

  late TextEditingController amountController;
  late TextEditingController weightController;
  late TextEditingController waterController;
  late TextEditingController saltController;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(
      text: widget.viewModel.amount.toString(),
    );
    weightController = TextEditingController(
      text: widget.viewModel.weightPerPortionG.toString(),
    );
    waterController = TextEditingController(
      text: widget.viewModel.waterPercentage.toString(),
    );
    saltController = TextEditingController(
      text: widget.viewModel.saltPercentage.toString(),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    weightController.dispose();
    waterController.dispose();
    saltController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Dough', style: Theme.of(context).textTheme.bodyLarge),
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Icon(
                    Icons.info_outline_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: amountController,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        widget.viewModel.setAmount(int.parse(value));
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        widget.viewModel.setWeightPerPortionG(
                          double.parse(value),
                        );
                      }
                    },
                    controller: weightController,
                    decoration: InputDecoration(
                      labelText: 'Weight',
                      suffixText: 'g',
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        widget.viewModel.setWaterPercentage(
                          double.parse(value),
                        );
                      }
                    },
                    controller: waterController,
                    decoration: InputDecoration(
                      labelText: 'Water',
                      suffixText: '%',
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        widget.viewModel.setSaltPercentage(double.parse(value));
                      }
                    },
                    controller: saltController,
                    decoration: InputDecoration(
                      labelText: 'Salt',
                      suffixText: '%',
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 5,
              children: [
                Text('Yeast', style: Theme.of(context).textTheme.bodyMedium),
                ToggleButtons(
                  borderRadius: BorderRadius.circular(5),
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < yeasts.length; i++) {
                        yeasts[i].isSelected = i == index;
                        if (yeasts[i].selected) {
                          widget.viewModel.setYeastType(
                            YeastType.values.firstWhere(
                              (type) =>
                                  type.name.toLowerCase() ==
                                  yeasts[i].name.toLowerCase(),
                            ),
                          );
                        }
                      }
                    });
                  },
                  constraints: const BoxConstraints(minHeight: 30.0),
                  isSelected: yeasts.map((yeast) => yeast.selected).toList(),
                  children:
                      yeasts.map((yeast) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(yeast.name),
                        );
                      }).toList(),
                ),
                SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
