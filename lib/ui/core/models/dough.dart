import 'package:dough_dock/ui/dough/enumerables/yeast_type.dart';
import 'package:flutter/material.dart';

class DoughViewModel extends ChangeNotifier {
  int amount;
  double weightPerPortionG;
  double waterPercentage; // hydration (% of flour weight)
  double saltPercentage; // salt (% of flour weight)
  double rtLeaveningHours;
  double rtTemperatureCelsius;
  YeastType yeastType;

  DoughViewModel({
    required this.amount,
    required this.weightPerPortionG,
    required this.waterPercentage,
    required this.saltPercentage,
    required this.rtLeaveningHours,
    required this.rtTemperatureCelsius,
    required this.yeastType,
  });

  // Calculate total flour from total dough weight using baker's formula:
  // TotalDough = Flour + Water + Salt + Yeast.  Water and salt are given
  // as percentages of flour; yeast ratio depends on type (fresh ≈0.2%, dry ≈0.067%, sourdough ≈10%).
  double getTotalFlour() {
    // Determine yeast ratio based on type (fraction of flour)
    double yeastRatio;
    switch (yeastType) {
      case YeastType.fresh:
        yeastRatio =
            0.002; // ~0.2% fresh yeast (e.g. ≈2g per kg flour):contentReference[oaicite:11]{index=11}:contentReference[oaicite:12]{index=12}
        break;
      case YeastType.dry:
        yeastRatio =
            0.00067; // ~0.067% dry yeast (≈1/3 of fresh):contentReference[oaicite:13]{index=13}
        break;
      case YeastType.sourdough:
        yeastRatio =
            0.10; // 10% sourdough starter (midpoint of 5–20%):contentReference[oaicite:14]{index=14}
        break;
    }
    final double totalDough = amount * weightPerPortionG;
    final double ratioSum =
        1.0 + (waterPercentage / 100.0) + (saltPercentage / 100.0) + yeastRatio;
    return totalDough / ratioSum;
  }

  // Total water = flour * hydration%
  double getTotalWater() {
    return getTotalFlour() * (waterPercentage / 100.0);
  }

  // Total salt = flour * salt%
  double getTotalSalt() {
    return getTotalFlour() * (saltPercentage / 100.0);
  }

  // Total yeast = flour * yeast ratio (based on type)
  double getTotalYeast() {
    double yeastRatio;
    switch (yeastType) {
      case YeastType.fresh:
        yeastRatio =
            0.002; // fresh yeast ratio (0.1–0.3% of flour):contentReference[oaicite:15]{index=15}:contentReference[oaicite:16]{index=16}
        break;
      case YeastType.dry:
        yeastRatio =
            0.00067; // dry ~1/3 of fresh:contentReference[oaicite:17]{index=17}
        break;
      case YeastType.sourdough:
        yeastRatio =
            0.10; // sourdough starter ~10% of flour:contentReference[oaicite:18]{index=18}
        break;
    }
    return getTotalFlour() * yeastRatio;
  }

  double getTotalDough() {
    return (amount * weightPerPortionG).toDouble();
  }

  // Setters (unchanged)
  void setAmount(int newAmount) {
    amount = newAmount;
    notifyListeners();
  }

  void setWeightPerPortionG(double newWeight) => weightPerPortionG = newWeight;
  void setWaterPercentage(double newWaterPercentage) =>
      waterPercentage = newWaterPercentage;
  void setSaltPercentage(double newSaltPercentage) =>
      saltPercentage = newSaltPercentage;
  void setRtLeaveningHours(double newRtLeaveningHours) =>
      rtLeaveningHours = newRtLeaveningHours;
  void setRtTemperatureCelsius(double newRtTemperatureCelsius) =>
      rtTemperatureCelsius = newRtTemperatureCelsius;
  void setYeastType(YeastType newYeastType) => yeastType = newYeastType;
}
