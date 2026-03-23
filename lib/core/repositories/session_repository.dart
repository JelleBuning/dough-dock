import 'dart:collection';

import 'package:dough_dock/core/models/dough_session.dart';

class SessionRepository {
  final List<DoughSession> _sessions = [];

  UnmodifiableListView<DoughSession> get sessions =>
      UnmodifiableListView(_sessions);

  void addSession(DoughSession session) {
    _sessions.add(session);
  }

  void removeSession(DoughSession session) {
    _sessions.remove(session);
  }
}
