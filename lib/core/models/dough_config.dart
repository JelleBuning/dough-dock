import 'package:dough_dock/core/enumerations/yeast_type.dart';

class DoughConfig {
  const DoughConfig({
    required this.amount,
    required this.yeastType,
    required this.rtTemperatureCelsius,
    required this.rtLeaveningHours,
    this.weightPerPortionG = 250.0,
    this.waterPercentage = 61.0,
    this.saltPercentage = 2.6,
  });

  final int amount;
  final YeastType yeastType;
  final double rtTemperatureCelsius;
  final double rtLeaveningHours;
  final double weightPerPortionG;
  final double waterPercentage;
  final double saltPercentage;
}
