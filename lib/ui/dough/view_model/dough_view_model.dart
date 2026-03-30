import 'package:dough_dock/core/enumerations/yeast_type.dart';
import 'package:dough_dock/core/models/dough_config.dart';
import 'package:dough_dock/core/models/dough_session.dart';
import 'package:dough_dock/core/repositories/session_repository.dart';
import 'package:dough_dock/core/services/dough_calculator.dart';
import 'package:dough_dock/core/services/dough_planner.dart';
import 'package:flutter/material.dart';

class DoughViewModel extends ChangeNotifier {
  DoughViewModel({
    int amount = DoughConfig.defaultAmount,
    double rtLeaveningHours = DoughConfig.defaultRtLeaveningHours,
    double rtTemperatureCelsius = DoughConfig.defaultRtTemperatureCelsius,
    YeastType yeastType = DoughConfig.defaultYeastType,
    double weightPerPortionG = DoughConfig.defaultWeightPerPortionG,
    double waterPercentage = DoughConfig.defaultWaterPercentage,
    double saltPercentage = DoughConfig.defaultSaltPercentage,
    required SessionRepository sessionRepository,
    required DoughCalculator calculator,
    required DoughPlanner planner,
  })  : assert(amount > 0, 'amount must be > 0'),
        assert(rtLeaveningHours > 0, 'rtLeaveningHours must be > 0'),
        assert(weightPerPortionG > 0, 'weightPerPortionG must be > 0'),
        assert(waterPercentage > 0, 'waterPercentage must be > 0'),
        assert(saltPercentage >= 0, 'saltPercentage must be >= 0'),
        _amount = amount,
        _rtLeaveningHours = rtLeaveningHours,
        _rtTemperatureCelsius = rtTemperatureCelsius,
        _yeastType = yeastType,
        _weightPerPortionG = weightPerPortionG,
        _waterPercentage = waterPercentage,
        _saltPercentage = saltPercentage,
        _sessionRepository = sessionRepository,
        _calculator = calculator,
        _planner = planner;

  final SessionRepository _sessionRepository;
  final DoughCalculator _calculator;
  final DoughPlanner _planner;

  int _amount;
  double _rtLeaveningHours;
  double _rtTemperatureCelsius;
  double _weightPerPortionG;
  double _waterPercentage;
  double _saltPercentage;
  YeastType _yeastType;
  DateTime? _bakeTime;

  int get amount => _amount;
  double get rtLeaveningHours => _rtLeaveningHours;
  double get rtTemperatureCelsius => _rtTemperatureCelsius;
  double get weightPerPortionG => _weightPerPortionG;
  double get waterPercentage => _waterPercentage;
  double get saltPercentage => _saltPercentage;
  YeastType get yeastType => _yeastType;
  DateTime? get bakeTime => _bakeTime;

  DoughConfig get _config => DoughConfig(
    amount: _amount,
    yeastType: _yeastType,
    rtTemperatureCelsius: _rtTemperatureCelsius,
    rtLeaveningHours: _rtLeaveningHours,
    weightPerPortionG: _weightPerPortionG,
    waterPercentage: _waterPercentage,
    saltPercentage: _saltPercentage,
  );

  double getTotalFlour() => _calculator.totalFlour(_config);
  double getTotalWater() => _calculator.totalWater(_config);
  double getTotalSalt() => _calculator.totalSalt(_config);
  double getTotalYeast() => _calculator.totalYeast(_config);
  double getTotalDough() => _calculator.totalDough(_config);

  Future<DoughSession> saveSession() async {
    final session = _planner.createSession(
      id: _sessionRepository.nextId(),
      config: _config,
      bakeTime: _bakeTime ?? DateTime.now().add(Duration(hours: _rtLeaveningHours.round())),
    );
    await _sessionRepository.addSession(session);
    return session;
  }

  void setBakeTime(DateTime newBakeTime) {
    _bakeTime = newBakeTime;
    notifyListeners();
  }

  void setAmount(int newAmount) {
    assert(newAmount > 0, 'amount must be > 0');
    _amount = newAmount;
    notifyListeners();
  }

  void setWeightPerPortionG(double newWeight) {
    assert(newWeight > 0, 'weightPerPortionG must be > 0');
    _weightPerPortionG = newWeight;
    notifyListeners();
  }

  void setWaterPercentage(double newWaterPercentage) {
    assert(newWaterPercentage > 0, 'waterPercentage must be > 0');
    _waterPercentage = newWaterPercentage;
    notifyListeners();
  }

  void setSaltPercentage(double newSaltPercentage) {
    assert(newSaltPercentage >= 0, 'saltPercentage must be >= 0');
    _saltPercentage = newSaltPercentage;
    notifyListeners();
  }

  void setRtLeaveningHours(double newRtLeaveningHours) {
    assert(newRtLeaveningHours > 0, 'rtLeaveningHours must be > 0');
    _rtLeaveningHours = newRtLeaveningHours;
    notifyListeners();
  }

  void setRtTemperatureCelsius(double newRtTemperatureCelsius) {
    _rtTemperatureCelsius = newRtTemperatureCelsius;
    notifyListeners();
  }

  void setYeastType(YeastType newYeastType) {
    _yeastType = newYeastType;
    notifyListeners();
  }
}
