import 'package:dough_dock/core/enumerations/yeast_type.dart';
import 'package:dough_dock/core/models/dough_session.dart';
import 'package:dough_dock/core/models/dough_step.dart';
import 'package:dough_dock/core/services/dough_calculator.dart';

class DoughPlanner {
  static DoughSession createSession({
    required DateTime bakeTime,
    required int amount,
    required double weightPerPortionG,
    required double waterPercentage,
    required double saltPercentage,
    required double rtLeaveningHours,
    required double rtTemperatureCelsius,
    required YeastType yeastType,
  }) {
    final totalFlour = DoughCalculator.totalFlour(
      amount: amount,
      weightPerPortionG: weightPerPortionG,
      waterPercentage: waterPercentage,
      saltPercentage: saltPercentage,
      yeastType: yeastType,
    );

    final totalFermentation = Duration(hours: rtLeaveningHours.round());
    final startTime = bakeTime.subtract(totalFermentation);
    final bulkEnd = startTime.add(
      Duration(hours: (rtLeaveningHours * 0.7).round()),
    );

    final steps = [
      DoughStep(name: 'Mix dough', time: startTime),
      DoughStep(name: 'Start bulk fermentation', time: startTime),
      DoughStep(name: 'Divide & ball dough', time: bulkEnd),
      DoughStep(name: 'Final proof (dough balls)', time: bulkEnd),
      DoughStep(name: 'Bake', time: bakeTime),
    ];

    return DoughSession(
      createdAt: DateTime.now(),
      amount: amount,
      weightPerPortionG: weightPerPortionG,
      waterPercentage: waterPercentage,
      saltPercentage: saltPercentage,
      rtLeaveningHours: rtLeaveningHours,
      rtTemperatureCelsius: rtTemperatureCelsius,
      yeastType: yeastType,
      bakeTime: bakeTime,
      totalFlour: totalFlour,
      totalWater: totalFlour * (waterPercentage / 100.0),
      totalSalt: totalFlour * (saltPercentage / 100.0),
      totalYeast: totalFlour * DoughCalculator.yeastRatio(yeastType),
      totalDough: DoughCalculator.totalDough(amount, weightPerPortionG),
      steps: steps,
    );
  }
}
