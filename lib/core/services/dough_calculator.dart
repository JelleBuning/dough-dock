import 'package:dough_dock/core/enumerations/yeast_type.dart';

abstract final class DoughCalculator {
  static double yeastRatio(YeastType yeastType) {
    switch (yeastType) {
      case YeastType.fresh:
        return 0.002;
      case YeastType.dry:
        return 0.00067;
      case YeastType.sourdough:
        return 0.10;
    }
  }

  static double totalDough(int amount, double weightPerPortionG) {
    return amount * weightPerPortionG;
  }

  static double totalFlour({
    required int amount,
    required double weightPerPortionG,
    required double waterPercentage,
    required double saltPercentage,
    required YeastType yeastType,
  }) {
    final dough = totalDough(amount, weightPerPortionG);
    final ratioSum =
        1.0 +
        (waterPercentage / 100.0) +
        (saltPercentage / 100.0) +
        yeastRatio(yeastType);
    return dough / ratioSum;
  }

  static double totalWater({
    required int amount,
    required double weightPerPortionG,
    required double waterPercentage,
    required double saltPercentage,
    required YeastType yeastType,
  }) {
    return totalFlour(
          amount: amount,
          weightPerPortionG: weightPerPortionG,
          waterPercentage: waterPercentage,
          saltPercentage: saltPercentage,
          yeastType: yeastType,
        ) *
        (waterPercentage / 100.0);
  }

  static double totalSalt({
    required int amount,
    required double weightPerPortionG,
    required double waterPercentage,
    required double saltPercentage,
    required YeastType yeastType,
  }) {
    return totalFlour(
          amount: amount,
          weightPerPortionG: weightPerPortionG,
          waterPercentage: waterPercentage,
          saltPercentage: saltPercentage,
          yeastType: yeastType,
        ) *
        (saltPercentage / 100.0);
  }

  static double totalYeast({
    required int amount,
    required double weightPerPortionG,
    required double waterPercentage,
    required double saltPercentage,
    required YeastType yeastType,
  }) {
    return totalFlour(
          amount: amount,
          weightPerPortionG: weightPerPortionG,
          waterPercentage: waterPercentage,
          saltPercentage: saltPercentage,
          yeastType: yeastType,
        ) *
        yeastRatio(yeastType);
  }
}
