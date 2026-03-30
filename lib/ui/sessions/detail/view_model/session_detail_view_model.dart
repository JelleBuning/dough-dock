import 'package:dough_dock/core/models/dough_session.dart';
import 'package:dough_dock/core/models/dough_step.dart';
import 'package:dough_dock/core/services/dough_calculator.dart';
import 'package:flutter/material.dart';

class SessionDetailViewModel extends ChangeNotifier {
  SessionDetailViewModel({
    required DoughSession session,
    required DoughCalculator calculator,
  })  : _session = session,
        _calculator = calculator,
        _completedCount = 0;

  final DoughSession _session;
  final DoughCalculator _calculator;
  int _completedCount;

  DoughSession get session => _session;
  List<DoughStep> get steps => _session.steps;

  double get totalFlour => _calculator.totalFlour(_session.config);
  double get totalWater => _calculator.totalWater(_session.config);
  double get totalSalt => _calculator.totalSalt(_session.config);
  double get totalYeast => _calculator.totalYeast(_session.config);
  double get totalDough => _calculator.totalDough(_session.config);

  int get currentStepIndex => _completedCount;
  bool get allCompleted => _completedCount >= steps.length;

  bool isCompleted(int index) => index < _completedCount;
  bool isCurrent(int index) => index == _completedCount && !allCompleted;

  DoughStep? get currentStep =>
      allCompleted ? null : steps[_completedCount];

  bool get isFirstStep => _completedCount == 0;
  bool get isLastStep => _completedCount == steps.length - 1;

  void nextStep() {
    if (!allCompleted) {
      _completedCount++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_completedCount > 0) {
      _completedCount--;
      notifyListeners();
    }
  }
}
