import 'dart:collection';

import 'package:dough_dock/core/models/dough_session.dart';
import 'package:dough_dock/core/repositories/session_repository.dart';
import 'package:flutter/material.dart';

class SessionsViewModel extends ChangeNotifier {
  SessionsViewModel({required SessionRepository sessionRepository})
      : _sessionRepository = sessionRepository {
    _sessionRepository.addListener(_onRepositoryChanged);
  }

  final SessionRepository _sessionRepository;

  void _onRepositoryChanged() => notifyListeners();

  UnmodifiableListView<DoughSession> get sessions =>
      _sessionRepository.sessions;

  Future<void> removeSession(DoughSession session) async {
    await _sessionRepository.removeSession(session);
  }

  @override
  void dispose() {
    _sessionRepository.removeListener(_onRepositoryChanged);
    super.dispose();
  }
}
