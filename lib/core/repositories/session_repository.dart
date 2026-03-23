import 'dart:collection';

import 'package:dough_dock/core/models/dough_session.dart';
import 'package:flutter/material.dart';

class SessionRepository extends ChangeNotifier {
  final List<DoughSession> _sessions = [];

  UnmodifiableListView<DoughSession> get sessions =>
      UnmodifiableListView(_sessions);

  Future<void> addSession(DoughSession session) async {
    _sessions.add(session);
    notifyListeners();
  }

  Future<void> removeSession(DoughSession session) async {
    _sessions.remove(session);
    notifyListeners();
  }
}
