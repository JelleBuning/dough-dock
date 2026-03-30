import 'dart:math';
import 'package:dough_dock/core/enumerations/yeast_type.dart';
import 'package:dough_dock/core/models/dough_config.dart';

class DoughCalculator {
  const DoughCalculator();

  static const double _yeastConstant = 0.025;

  double totalFlour(DoughConfig config) {
    final double waterDecimal = config.waterPercentage / 100.0;
    final double saltDecimal = config.saltPercentage / 100.0;

    final double flourPerBall =
        config.weightPerPortionG / (1.0 + waterDecimal + saltDecimal);

    return flourPerBall * config.amount;
  }

  double totalDough(DoughConfig config) =>
      config.weightPerPortionG * config.amount;

  double totalWater(DoughConfig config) {
    return totalFlour(config) * (config.waterPercentage / 100.0);
  }

  double totalSalt(DoughConfig config) {
    return totalFlour(config) * (config.saltPercentage / 100.0);
  }

  double totalYeast(DoughConfig config) {
    final double flour = totalFlour(config);

    final tempFactor = exp(0.09 * (config.rtTemperatureCelsius - 20.0));
    final percentage = _yeastConstant / (config.rtLeaveningHours * tempFactor);

    return flour * percentage * _yeastMultiplier(config.yeastType);
  }

  double _yeastMultiplier(YeastType yeastType) {
    switch (yeastType) {
      case YeastType.fresh:
        return 1.0;
      case YeastType.activeDry:
        return 0.5; // AVPN generally recommends 1:2 ratio for Active Dry
      case YeastType.instant:
        return 0.33; // 1:3 ratio for Instant
    }
  }
}
