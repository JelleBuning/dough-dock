import 'package:dough_dock/core/enumerations/yeast_type.dart';
import 'package:dough_dock/core/repositories/session_repository.dart';
import 'package:dough_dock/core/services/dough_calculator.dart';
import 'package:dough_dock/core/services/dough_planner.dart';
import 'package:flutter/material.dart';

class DoughViewModel extends ChangeNotifier {
  int amount;
  double weightPerPortionG;
  double waterPercentage;
  double saltPercentage;
  double rtLeaveningHours;
  double rtTemperatureCelsius;
  YeastType yeastType;

  DateTime? bakeTime;

  final SessionRepository _sessionRepository;

  DoughViewModel({
    required this.amount,
    required this.weightPerPortionG,
    required this.waterPercentage,
    required this.saltPercentage,
    required this.rtLeaveningHours,
    required this.rtTemperatureCelsius,
    required this.yeastType,
    required SessionRepository sessionRepository,
  }) : _sessionRepository = sessionRepository;

  double getTotalFlour() => DoughCalculator.totalFlour(
    amount: amount,
    weightPerPortionG: weightPerPortionG,
    waterPercentage: waterPercentage,
    saltPercentage: saltPercentage,
    yeastType: yeastType,
  );

  double getTotalWater() => DoughCalculator.totalWater(
    amount: amount,
    weightPerPortionG: weightPerPortionG,
    waterPercentage: waterPercentage,
    saltPercentage: saltPercentage,
    yeastType: yeastType,
  );

  double getTotalSalt() => DoughCalculator.totalSalt(
    amount: amount,
    weightPerPortionG: weightPerPortionG,
    waterPercentage: waterPercentage,
    saltPercentage: saltPercentage,
    yeastType: yeastType,
  );

  double getTotalYeast() => DoughCalculator.totalYeast(
    amount: amount,
    weightPerPortionG: weightPerPortionG,
    waterPercentage: waterPercentage,
    saltPercentage: saltPercentage,
    yeastType: yeastType,
  );

  double getTotalDough() => DoughCalculator.totalDough(amount, weightPerPortionG);

  void saveSession() {
    final session = DoughPlanner.createSession(
      bakeTime: bakeTime ?? DateTime.now().add(Duration(hours: rtLeaveningHours.round())),
      amount: amount,
      weightPerPortionG: weightPerPortionG,
      waterPercentage: waterPercentage,
      saltPercentage: saltPercentage,
      rtLeaveningHours: rtLeaveningHours,
      rtTemperatureCelsius: rtTemperatureCelsius,
      yeastType: yeastType,
    );
    _sessionRepository.addSession(session);
  }

  void setBakeTime(DateTime newBakeTime) {
    bakeTime = newBakeTime;
    notifyListeners();
  }

  void setAmount(int newAmount) {
    amount = newAmount;
    notifyListeners();
  }

  void setWeightPerPortionG(double newWeight) {
    weightPerPortionG = newWeight;
    notifyListeners();
  }

  void setWaterPercentage(double newWaterPercentage) {
    waterPercentage = newWaterPercentage;
    notifyListeners();
  }

  void setSaltPercentage(double newSaltPercentage) {
    saltPercentage = newSaltPercentage;
    notifyListeners();
  }

  void setRtLeaveningHours(double newRtLeaveningHours) {
    rtLeaveningHours = newRtLeaveningHours;
    notifyListeners();
  }

  void setRtTemperatureCelsius(double newRtTemperatureCelsius) {
    rtTemperatureCelsius = newRtTemperatureCelsius;
    notifyListeners();
  }

  void setYeastType(YeastType newYeastType) {
    yeastType = newYeastType;
    notifyListeners();
  }
}
