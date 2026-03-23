import 'package:dough_dock/core/models/ingredient.dart';
import 'package:dough_dock/core/models/pizza.dart';
import 'package:dough_dock/core/repositories/pizza_repository.dart';
import 'package:flutter/material.dart';

class ToppingsViewModel extends ChangeNotifier {
  ToppingsViewModel({required PizzaRepository pizzaRepository})
    : _pizzaRepository = pizzaRepository {
    fetchData();
  }

  final PizzaRepository _pizzaRepository;

  List<Ingredient> ingredients = [];
  List<Pizza> pizzas = [];
  List<Ingredient> selectedIngredients = const [
    Ingredient(name: 'Tomato Sauce'),
    Ingredient(name: 'Mozzarella'),
  ];
  List<Pizza> suggestions = [];

  bool isLoading = false;
  String? error;

  Future<void> fetchData() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      pizzas = await _pizzaRepository.fetchPizzas();
      ingredients = await _pizzaRepository.fetchIngredients();
      _updateSuggestions();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void selectIngredient(Ingredient ingredient) {
    assert(!selectedIngredients.contains(ingredient), 'Ingredient already selected');
    selectedIngredients = List.unmodifiable([...selectedIngredients, ingredient]);
    _updateSuggestions();
    notifyListeners();
  }

  void removeIngredient(Ingredient ingredient) {
    selectedIngredients = List.unmodifiable(
      selectedIngredients.where((i) => i != ingredient),
    );
    _updateSuggestions();
    notifyListeners();
  }

  void _updateSuggestions() {
    final selectedNames = selectedIngredients.map((e) => e.name).toSet();
    suggestions = pizzas.where((pizza) {
      final missing = pizza.ingredients.toSet().difference(selectedNames);
      return missing.length <= 1;
    }).toList();
  }
}
