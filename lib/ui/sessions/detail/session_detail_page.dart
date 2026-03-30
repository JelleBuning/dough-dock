import 'package:dough_dock/core/models/dough_step.dart';
import 'package:dough_dock/core/services/notification_service.dart';
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
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          viewModel.allCompleted
              ? _AllDoneCard(bakeTime: viewModel.session.bakeTime)
              : _CurrentStepCard(
                step: viewModel.currentStep!,
                stepNumber: viewModel.currentStepIndex + 1,
                totalSteps: viewModel.steps.length,
                isFirst: viewModel.isFirstStep,
                isLast: viewModel.isLastStep,
                onPrevious:
                    () => context.read<SessionDetailViewModel>().previousStep(),
                onNext: () => context.read<SessionDetailViewModel>().nextStep(),
                viewModel: viewModel.isFirstStep ? viewModel : null,
              ),
          const SizedBox(height: 20),
          Text('Steps', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 10),
          ...viewModel.steps.asMap().entries.map((entry) {
            return _StepTimelineItem(
              step: entry.value,
              isCompleted: viewModel.isCompleted(entry.key),
              isCurrent: viewModel.isCurrent(entry.key),
            );
          }),
          _DoneTimelinePoint(
            bakeTime: viewModel.session.bakeTime,
            allCompleted: viewModel.allCompleted,
          ),
        ],
      ),
    );
  }
}

class _CurrentStepCard extends StatelessWidget {
  const _CurrentStepCard({
    required this.step,
    required this.stepNumber,
    required this.totalSteps,
    required this.isFirst,
    required this.isLast,
    required this.onPrevious,
    required this.onNext,
    this.viewModel,
  });

  final DoughStep step;
  final int stepNumber;
  final int totalSteps;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final SessionDetailViewModel? viewModel;

  @override
  Widget build(BuildContext context) {
    final onContainer = Theme.of(context).colorScheme.onSecondaryContainer;

    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Step $stepNumber of $totalSteps',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: onContainer,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    DateFormat('HH:mm').format(step.time),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: onContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              step.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: onContainer,
              ),
            ),
            if (step.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                step.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: onContainer.withValues(alpha: 0.8),
                ),
              ),
            ],
            if (viewModel != null) ...[
              Divider(
                height: 28,
                color: onContainer.withValues(alpha: 0.2),
              ),
              _IngredientsSection(viewModel: viewModel!, onContainer: onContainer),
              const SizedBox(height: 4),
            ],
            const SizedBox(height: 10),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: isFirst ? null : onPrevious,
                    child: const Text('Previous'),
                  ),
                ),
                Expanded(
                  child: FilledButton(
                    onPressed: onNext,
                    child: Text(isLast ? 'Finish' : 'Next'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IngredientsSection extends StatelessWidget {
  const _IngredientsSection({
    required this.viewModel,
    required this.onContainer,
  });

  final SessionDetailViewModel viewModel;
  final Color onContainer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: onContainer,
          ),
        ),
        const SizedBox(height: 10),
        _IngredientRow(label: 'Flour', grams: viewModel.totalFlour, color: onContainer),
        _IngredientRow(label: 'Water', grams: viewModel.totalWater, color: onContainer),
        _IngredientRow(label: 'Salt', grams: viewModel.totalSalt, color: onContainer),
        _IngredientRow(label: 'Yeast', grams: viewModel.totalYeast, color: onContainer),
        Divider(height: 20, color: onContainer.withValues(alpha: 0.2)),
        _IngredientRow(label: 'Total dough', grams: viewModel.totalDough, bold: true, color: onContainer),
      ],
    );
  }
}

class _IngredientRow extends StatelessWidget {
  const _IngredientRow({required this.label, required this.grams, this.bold = false, this.color});

  final String label;
  final double grams;
  final bool bold;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: bold ? FontWeight.w600 : null,
      color: color,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text('${grams.toStringAsFixed(1)} g', style: style),
        ],
      ),
    );
  }
}

class _AllDoneCard extends StatelessWidget {
  const _AllDoneCard({required this.bakeTime});

  final DateTime bakeTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All steps done!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your dough is ready to bake at ${DateFormat('HH:mm').format(bakeTime)}. Enjoy your pizza!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await NotificationService.instance.scheduleBakeReminder(
                    bakeTime,
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Reminder set for ${DateFormat('HH:mm').format(bakeTime)}',
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.notifications_outlined),
                label: const Text('Notify me'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepTimelineItem extends StatelessWidget {
  const _StepTimelineItem({
    required this.step,
    required this.isCompleted,
    required this.isCurrent,
  });

  final DoughStep step;
  final bool isCompleted;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final dotColor =
        isCompleted || isCurrent
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isCompleted
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                    border: Border.all(color: dotColor, width: 2),
                  ),
                  child:
                      isCompleted
                          ? Icon(
                            Icons.check_rounded,
                            size: 12,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                          : null,
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color:
                        isCompleted
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.15),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  Text(
                    step.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          isCompleted || isCurrent
                              ? Theme.of(context).colorScheme.onSurface
                              : Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.45),
                      fontWeight: isCurrent ? FontWeight.w600 : null,
                      decoration:
                          isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(
                    DateFormat('HH:mm').format(step.time),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant.withValues(
                        alpha: isCompleted || isCurrent ? 1.0 : 0.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoneTimelinePoint extends StatelessWidget {
  const _DoneTimelinePoint({
    required this.bakeTime,
    required this.allCompleted,
  });

  final DateTime bakeTime;
  final bool allCompleted;

  @override
  Widget build(BuildContext context) {
    final color =
        allCompleted
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3);

    return Row(
      children: [
        SizedBox(
          width: 24,
          child: Center(
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    allCompleted
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                border: Border.all(color: color, width: 2),
              ),
              child:
                  allCompleted
                      ? Icon(
                        Icons.local_pizza_rounded,
                        size: 12,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )
                      : null,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 2,
          children: [
            Text(
              'Bake',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:
                    allCompleted
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.45),
                fontWeight: allCompleted ? FontWeight.w600 : null,
              ),
            ),
            Text(
              DateFormat('HH:mm').format(bakeTime),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant
                    .withValues(alpha: allCompleted ? 1.0 : 0.45),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
