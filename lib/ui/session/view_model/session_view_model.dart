import 'package:dough_dock/data/repositories/pizza_repository.dart';
import 'package:dough_dock/domain/models/ingredient.dart';
import 'package:dough_dock/domain/models/pizza.dart';
import 'package:flutter/material.dart';

class SessionViewModel extends ChangeNotifier {
  SessionViewModel({required PizzaRepository pizzaRepository})
    : _pizzaRepository = pizzaRepository {
    fetchData();
    _updateSuggestions();
    notifyListeners();
  }
  final PizzaRepository _pizzaRepository;

  List<Ingredient> ingredients = [];
  List<Pizza> pizzas = [];

  List<Ingredient> selectedIngredients = [
    Ingredient(name: "Tomato Sauce"),
    Ingredient(name: "Mozzarella"),
  ];
  List<Pizza> suggestions = [];

  void fetchData() {
    pizzas = _pizzaRepository.fetchPizzas();
    ingredients = _pizzaRepository.fetchIngredients();
  }

  void selectIngredient(Ingredient ingredient) {
    selectedIngredients.add(ingredient);

    _updateSuggestions();
    notifyListeners();
  }

  void removeIngredient(Ingredient ingredient) {
    selectedIngredients.remove(ingredient);

    _updateSuggestions();
    notifyListeners();
  }

  void _updateSuggestions() {
    suggestions =
        pizzas.where((pizza) {
          final selectedIngredientNames =
              selectedIngredients.map((e) => e.name).toSet();
          final pizzaIngredientNames = pizza.ingredients.toSet();
          final missingIngredients = pizzaIngredientNames.difference(
            selectedIngredientNames,
          );
          return missingIngredients.length <= 1;
        }).toList();
  }
}
