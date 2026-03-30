import 'package:dough_dock/core/enumerations/yeast_type.dart';

class DoughConfig {
  static const int defaultAmount = 4;
  static const YeastType defaultYeastType = YeastType.fresh;
  static const double defaultRtTemperatureCelsius = 20.0;
  static const double defaultRtLeaveningHours = 24.0;
  static const double defaultWeightPerPortionG = 250.0;
  static const double defaultWaterPercentage = 60.0;
  static const double defaultSaltPercentage = 2.6;

  const DoughConfig({
    this.amount = defaultAmount,
    this.yeastType = defaultYeastType,
    this.rtTemperatureCelsius = defaultRtTemperatureCelsius,
    this.rtLeaveningHours = defaultRtLeaveningHours,
    this.weightPerPortionG = defaultWeightPerPortionG,
    this.waterPercentage = defaultWaterPercentage,
    this.saltPercentage = defaultSaltPercentage,
  });

  final int amount;
  final YeastType yeastType;
  final double rtTemperatureCelsius;
  final double rtLeaveningHours;
  final double weightPerPortionG;
  final double waterPercentage;
  final double saltPercentage;
}
