import 'package:dough_dock/core/models/dough_session.dart';
import 'package:dough_dock/core/models/dough_step.dart';
import 'package:flutter/material.dart';

class SessionDetailViewModel extends ChangeNotifier {
  SessionDetailViewModel({required DoughSession session})
      : _session = session,
        _completed = List.filled(session.steps.length, false);

  final DoughSession _session;
  final List<bool> _completed;

  DoughSession get session => _session;
  List<DoughStep> get steps => _session.steps;

  bool isCompleted(int index) => _completed[index];

  void toggleStep(int index) {
    assert(index >= 0 && index < _completed.length);
    _completed[index] = !_completed[index];
    notifyListeners();
  }

  bool get allCompleted => _completed.every((c) => c);
}
