import 'package:dough_dock/ui/sessions/detail/view_model/session_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SessionDetailPage extends StatelessWidget {
  const SessionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SessionDetailViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Bake ${DateFormat('EEE, MMM d').format(viewModel.session.bakeTime)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        itemCount: viewModel.steps.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final step = viewModel.steps[index];
          final completed = viewModel.isCompleted(index);

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            leading: Checkbox(
              value: completed,
              onChanged: (_) => context.read<SessionDetailViewModel>().toggleStep(index),
            ),
            title: Text(
              step.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                decoration: completed ? TextDecoration.lineThrough : null,
                color: completed
                    ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4)
                    : null,
              ),
            ),
            trailing: Text(
              DateFormat('HH:mm').format(step.time),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            onTap: () => context.read<SessionDetailViewModel>().toggleStep(index),
          );
        },
      ),
    );
  }
}
