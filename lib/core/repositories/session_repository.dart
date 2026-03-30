import 'dart:collection';

import 'package:dough_dock/core/models/dough_session.dart';
import 'package:flutter/material.dart';

class SessionRepository extends ChangeNotifier {
  final List<DoughSession> _sessions = [];
  int _nextId = 1;

  UnmodifiableListView<DoughSession> get sessions =>
      UnmodifiableListView(_sessions);

  DoughSession? getById(int id) {
    try {
      return _sessions.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> addSession(DoughSession session) async {
    _sessions.add(session);
    notifyListeners();
  }

  int nextId() => _nextId++;

  Future<void> removeSession(DoughSession session) async {
    _sessions.remove(session);
    notifyListeners();
  }
}
