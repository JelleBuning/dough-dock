import 'package:dough_dock/core/models/ingredient.dart';
import 'package:dough_dock/core/models/pizza.dart';
import 'package:dough_dock/ui/toppings/view_model/toppings_view_model.dart';
import 'package:flutter/material.dart';

class ToppingsPage extends StatefulWidget {
  const ToppingsPage({super.key, required this.viewModel});

  final ToppingsViewModel viewModel;

  @override
  State<ToppingsPage> createState() => _ToppingsPageState();
}

class _ToppingsPageState extends State<ToppingsPage> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.fetchData();
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed:
                () => widget.viewModel.selectIngredient(
                  widget.viewModel.ingredients.firstWhere(
                    (ingredient) =>
                        !widget.viewModel.selectedIngredients.any(
                          (selectedIngredient) =>
                              selectedIngredient.name == ingredient.name,
                        ),
                  ),
                ),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ingredients(), suggestionsWidget()],
          ),
        ),
      ),
    );
  }

  Widget ingredients() {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder:
          (context, child) => Wrap(
            spacing: 7.5,
            runSpacing: 7.5,
            children:
                widget.viewModel.selectedIngredients
                    .map((ingredient) => ingredientWidget(ingredient))
                    .toList(),
          ),
    );
  }

  Widget suggestionsWidget() {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder:
          (context, child) =>
              widget.viewModel.suggestions.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suggestions',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Column(
                        spacing: 10,
                        children:
                            widget.viewModel.suggestions
                                .map((suggestion) => suggestionCard(suggestion))
                                .toList(),
                      ),
                    ],
                  ),
    );
  }

  Card suggestionCard(Pizza pizza) {
    var selected = false; // Placeholder for selection state
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
                  pizza.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    children: [
                      TextSpan(
                        children:
                            pizza.ingredients
                                .map(
                                  (ingredient) => TextSpan(
                                    style:
                                        !widget.viewModel.selectedIngredients
                                                .any(
                                                  (i) => i.name == ingredient,
                                                )
                                            ? TextStyle(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.error,
                                            )
                                            : null,
                                    text:
                                        ingredient +
                                        (pizza.ingredients.last != ingredient
                                            ? ", "
                                            : ""),
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Checkbox(
              value: selected,
              onChanged: (value) {
                setState(() {
                  selected = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget ingredientWidget(Ingredient ingredient) => Card(
    color: Theme.of(context).colorScheme.secondaryContainer,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        spacing: 5,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(ingredient.name),
          InkWell(
            onTap: () => widget.viewModel.removeIngredient(ingredient),
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
