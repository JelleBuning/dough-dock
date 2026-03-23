import 'package:dough_dock/core/enumerations/yeast_type.dart';
import 'package:dough_dock/ui/dough/models/yeast.dart';
import 'package:dough_dock/ui/dough/view_model/dough_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoughConfigurator extends StatefulWidget {
  const DoughConfigurator({super.key});

  @override
  State<DoughConfigurator> createState() => _DoughConfiguratorState();
}

class _DoughConfiguratorState extends State<DoughConfigurator> {
  final List<Yeast> _yeasts = [
    Yeast(name: 'Fresh', selected: true),
    Yeast(name: 'Active Dry'),
    Yeast(name: 'Instant'),
  ];

  late TextEditingController _amountController;
  late TextEditingController _weightController;
  late TextEditingController _waterController;
  late TextEditingController _saltController;
  late TextEditingController _leaveningController;
  late TextEditingController _temperatureController;

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<DoughViewModel>();
    _amountController = TextEditingController(
      text: viewModel.amount.toString(),
    );
    _weightController = TextEditingController(
      text: viewModel.weightPerPortionG.toString(),
    );
    _waterController = TextEditingController(
      text: viewModel.waterPercentage.toString(),
    );
    _saltController = TextEditingController(
      text: viewModel.saltPercentage.toString(),
    );
    _leaveningController = TextEditingController(
      text: viewModel.rtLeaveningHours.toString(),
    );
    _temperatureController = TextEditingController(
      text: viewModel.rtTemperatureCelsius.toString(),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _weightController.dispose();
    _waterController.dispose();
    _saltController.dispose();
    _leaveningController.dispose();
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<DoughViewModel>();

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
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        viewModel.setAmount(int.parse(value));
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Pizzas',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        viewModel.setWeightPerPortionG(double.parse(value));
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Weight',
                      suffixText: 'g',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
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
                    controller: _waterController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        viewModel.setWaterPercentage(double.parse(value));
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Water',
                      suffixText: '%',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _saltController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        viewModel.setSaltPercentage(double.parse(value));
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Salt',
                      suffixText: '%',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
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
              spacing: 10,
              children: [
                Text(
                  'Fermentation',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _leaveningController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            viewModel.setRtLeaveningHours(double.parse(value));
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Duration',
                          suffixText: 'h',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _temperatureController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            viewModel.setRtTemperatureCelsius(
                              double.parse(value),
                            );
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Temp',
                          suffixText: '°C',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                      for (int i = 0; i < _yeasts.length; i++) {
                        _yeasts[i].isSelected = i == index;
                      }
                      viewModel.setYeastType(YeastType.values[index]);
                    });
                  },
                  constraints: const BoxConstraints(minHeight: 30.0),
                  isSelected: _yeasts.map((y) => y.selected).toList(),
                  children:
                      _yeasts
                          .map(
                            (y) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(y.name),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
