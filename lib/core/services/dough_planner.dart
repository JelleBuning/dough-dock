import 'package:dough_dock/core/models/dough_config.dart';
import 'package:dough_dock/core/models/dough_session.dart';
import 'package:dough_dock/core/models/dough_step.dart';

class DoughPlanner {
  const DoughPlanner();

  DoughSession createSession({
    required DoughConfig config,
    required DateTime bakeTime,
  }) {
    final totalFermentation = Duration(hours: config.rtLeaveningHours.round());
    final startTime = bakeTime.subtract(totalFermentation);
    final bulkEnd = startTime.add(
      Duration(hours: (config.rtLeaveningHours * 0.7).round()),
    );

    return DoughSession(
      createdAt: DateTime.now(),
      config: config,
      bakeTime: bakeTime,
      steps: [
        DoughStep(name: 'Mix dough', time: startTime),
        DoughStep(name: 'Start bulk fermentation', time: startTime),
        DoughStep(name: 'Divide & ball dough', time: bulkEnd),
        DoughStep(name: 'Final proof (dough balls)', time: bulkEnd),
        DoughStep(name: 'Bake', time: bakeTime),
      ],
    );
  }
}
