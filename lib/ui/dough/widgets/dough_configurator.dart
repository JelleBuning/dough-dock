import 'package:dough_dock/ui/dough/enumerables/yeast_type.dart';
import 'package:dough_dock/ui/core/models/dough.dart';
import 'package:dough_dock/ui/core/models/yeast.dart';
import 'package:flutter/material.dart';

class DoughConfigurator extends StatefulWidget {
  final DoughViewModel dough;
  final Function(DoughViewModel) onDoughChanged;

  const DoughConfigurator({
    super.key,
    required this.dough,
    required this.onDoughChanged,
  });

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
      text: widget.dough.amount.toString(),
    );
    weightController = TextEditingController(
      text: widget.dough.weightPerPortionG.toString(),
    );
    waterController = TextEditingController(
      text: widget.dough.waterPercentage.toString(),
    );
    saltController = TextEditingController(
      text: widget.dough.saltPercentage.toString(),
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
                        setState(() {
                          widget.dough.setAmount(int.parse(value));
                          widget.onDoughChanged(widget.dough);
                        });
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
                        setState(() {
                          widget.dough.setWeightPerPortionG(
                            double.parse(value),
                          );
                          widget.onDoughChanged(widget.dough);
                        });
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
                        setState(() {
                          widget.dough.setWaterPercentage(double.parse(value));
                          widget.onDoughChanged(widget.dough);
                        });
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
                        setState(() {
                          widget.dough.setSaltPercentage(double.parse(value));
                          widget.onDoughChanged(widget.dough);
                        });
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
                          setState(() {
                            widget.dough.setYeastType(
                              YeastType.values.firstWhere(
                                (type) =>
                                    type.name.toLowerCase() ==
                                    yeasts[i].name.toLowerCase(),
                              ),
                            );
                            widget.onDoughChanged(widget.dough);
                          });
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
