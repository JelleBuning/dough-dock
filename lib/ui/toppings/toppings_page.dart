import 'package:dough_dock/core/models/ingredient.dart';
import 'package:dough_dock/core/models/pizza.dart';
import 'package:dough_dock/ui/toppings/view_model/toppings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToppingsPage extends StatelessWidget {
  const ToppingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ToppingsViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Ingredients',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actionsPadding: const EdgeInsets.only(right: 10),
        actions: [
          IconButton(
            onPressed: viewModel.isLoading
                ? null
                : () {
                    final next = viewModel.ingredients.firstWhereOrNull(
                      (ingredient) => !viewModel.selectedIngredients.any(
                        (selected) => selected.name == ingredient.name,
                      ),
                    );
                    if (next != null) viewModel.selectIngredient(next);
                  },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.error != null
              ? Center(child: Text(viewModel.error!))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      spacing: 15,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _IngredientsWrap(viewModel: viewModel),
                        _SuggestionsSection(viewModel: viewModel),
                      ],
                    ),
                  ),
                ),
    );
  }
}

extension _FirstWhereOrNull<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}

class _IngredientsWrap extends StatelessWidget {
  const _IngredientsWrap({required this.viewModel});
  final ToppingsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7.5,
      runSpacing: 7.5,
      children: viewModel.selectedIngredients
          .map((ingredient) => _IngredientChip(
                ingredient: ingredient,
                onRemove: () => viewModel.removeIngredient(ingredient),
              ))
          .toList(),
    );
  }
}

class _SuggestionsSection extends StatelessWidget {
  const _SuggestionsSection({required this.viewModel});
  final ToppingsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel.suggestions.isEmpty) return const SizedBox.shrink();

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Suggestions', style: Theme.of(context).textTheme.bodyLarge),
        Column(
          spacing: 10,
          children: viewModel.suggestions
              .map((pizza) => _SuggestionCard(pizza: pizza, viewModel: viewModel))
              .toList(),
        ),
      ],
    );
  }
}

class _SuggestionCard extends StatefulWidget {
  const _SuggestionCard({required this.pizza, required this.viewModel});
  final Pizza pizza;
  final ToppingsViewModel viewModel;

  @override
  State<_SuggestionCard> createState() => _SuggestionCardState();
}

class _SuggestionCardState extends State<_SuggestionCard> {
  var _selected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.pizza.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    children: widget.pizza.ingredients
                        .map(
                          (ingredient) => TextSpan(
                            style: widget.viewModel.selectedIngredients.any(
                                      (i) => i.name == ingredient,
                                    )
                                ? null
                                : TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            text: ingredient +
                                (widget.pizza.ingredients.last != ingredient
                                    ? ', '
                                    : ''),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            Checkbox(
              value: _selected,
              onChanged: (value) => setState(() => _selected = value ?? false),
            ),
          ],
        ),
      ),
    );
  }
}

class _IngredientChip extends StatelessWidget {
  const _IngredientChip({required this.ingredient, required this.onRemove});
  final Ingredient ingredient;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(ingredient.name),
            InkWell(
              onTap: onRemove,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Icon(
                Icons.close_rounded,
                size: 15,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
