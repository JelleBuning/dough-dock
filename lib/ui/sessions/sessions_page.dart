import 'package:dough_dock/core/models/dough_session.dart';
import 'package:dough_dock/routing/routes.dart';
import 'package:dough_dock/ui/sessions/view_model/sessions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SessionsViewModel>();
    final sessions = viewModel.sessions;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Sessions',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body:
          sessions.isEmpty
              ? const Center(child: Text('No sessions saved yet.'))
              : ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                itemCount: sessions.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final session = sessions[index];
                  return _SessionCard(
                    session: session,
                    onTap: () => context.go(Routes.home.sessionDetail(session.id)),
                    onDismissed: () => context.read<SessionsViewModel>().removeSession(session),
                  );
                },
              ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({
    required this.session,
    required this.onTap,
    required this.onDismissed,
  });

  final DoughSession session;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(session),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.delete_outline_rounded, color: Theme.of(context).colorScheme.onError),
      ),
      onDismissed: (_) => onDismissed(),
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        'Bake ${DateFormat('EEE, MMM d – HH:mm').format(session.bakeTime)}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '${session.config.amount} pizza${session.config.amount == 1 ? '' : 's'} · ${_yeastLabel(session.config.yeastType.name)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _yeastLabel(String name) {
    switch (name) {
      case 'fresh':
        return 'Fresh yeast';
      case 'activeDry':
        return 'Active dry yeast';
      case 'instant':
        return 'Instant yeast';
      default:
        return name;
    }
  }
}
