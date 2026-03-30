import 'package:dough_dock/core/models/dough_config.dart';
import 'package:dough_dock/core/models/dough_session.dart';
import 'package:dough_dock/core/models/dough_step.dart';

class DoughPlanner {
  const DoughPlanner();

  DoughSession createSession({
    required int id,
    required DoughConfig config,
    required DateTime bakeTime,
  }) {
    final totalFermentation = Duration(hours: config.rtLeaveningHours.round());
    final startTime = bakeTime.subtract(totalFermentation);
    final bulkEnd = startTime.add(
      Duration(hours: (config.rtLeaveningHours * 0.7).round()),
    );

    return DoughSession(
      id: id,
      createdAt: DateTime.now(),
      config: config,
      bakeTime: bakeTime,
      steps: [
        DoughStep(
          name: 'Mix & bulk ferment',
          time: startTime,
          description:
              'Combine flour, water, salt and yeast. Mix until smooth, then cover and leave to ferment at room temperature.',
        ),
        DoughStep(
          name: 'Divide & shape',
          time: bulkEnd,
          description:
              'Divide the dough into equal portions and shape into tight balls.',
        ),
        DoughStep(
          name: 'Final proof',
          time: bulkEnd,
          description:
              'Place the dough balls in proofing containers, cover and let them rest until ready to stretch.',
        ),
      ],
    );
  }
}
