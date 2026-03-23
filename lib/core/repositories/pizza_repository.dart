import 'package:dough_dock/core/models/ingredient.dart';
import 'package:dough_dock/core/models/pizza.dart';

class PizzaRepository {
  List<Pizza> fetchPizzas() {
    return [
      Pizza(name: 'Margherita', ingredients: ['Tomato Sauce', 'Mozzarella']),
      Pizza(
        name: 'Marinara',
        ingredients: ['Tomato Sauce', 'Garlic', 'Oregano'],
      ),
      Pizza(
        name: 'Quattro Stagioni',
        ingredients: [
          'Tomato Sauce',
          'Mozzarella',
          'Artichokes',
          'Ham',
          'Mushrooms',
          'Olives',
        ],
      ),
      Pizza(
        name: 'Diavola',
        ingredients: ['Tomato Sauce', 'Mozzarella', 'Spicy Salami'],
      ),
      Pizza(
        name: 'Quattro Formaggi',
        ingredients: [
          'Tomato Sauce',
          'Mozzarella',
          'Gorgonzola',
          'Parmesan',
          'Fontina',
        ],
      ),
      Pizza(
        name: 'Napoli',
        ingredients: [
          'Tomato Sauce',
          'Mozzarella',
          'Anchovies',
          'Capers',
          'Olives',
        ],
      ),
      Pizza(
        name: 'Funghi',
        ingredients: ['Tomato Sauce', 'Mozzarella', 'Mushrooms'],
      ),
      Pizza(
        name: 'Prosciutto e Funghi',
        ingredients: ['Tomato Sauce', 'Mozzarella', 'Ham', 'Mushrooms'],
      ),
      Pizza(
        name: 'Salsiccia',
        ingredients: ['Tomato Sauce', 'Mozzarella', 'Italian Sausage'],
      ),
      Pizza(
        name: 'Frutti di Mare',
        ingredients: ['Tomato Sauce', 'Mozzarella', 'Mixed Seafood'],
      ),
      Pizza(
        name: 'Ortolana',
        ingredients: ['Tomato Sauce', 'Mozzarella', 'Grilled Vegetables'],
      ),
      Pizza(
        name: 'Pugliese',
        ingredients: ['Tomato Sauce', 'Mozzarella', 'Onions'],
      ),
    ];
  }

  List<Ingredient> fetchIngredients() {
    return [
      Ingredient(name: 'Tomato Sauce'),
      Ingredient(name: 'Mozzarella'),
      Ingredient(name: 'Mushrooms'),
      Ingredient(name: 'Olives'),
      Ingredient(name: 'Ham'),
      Ingredient(name: 'Artichokes'),
      Ingredient(name: 'Buffalo Mozzarella'),
      Ingredient(name: 'Spicy Salami'),
      Ingredient(name: 'Gorgonzola'),
      Ingredient(name: 'Parmesan'),
      Ingredient(name: 'Fontina'),
      Ingredient(name: 'Anchovies'),
      Ingredient(name: 'Capers'),
      Ingredient(name: 'Italian Sausage'),
      Ingredient(name: 'Mixed Seafood'),
      Ingredient(name: 'Grilled Vegetables'),
      Ingredient(name: 'Onions'),
    ];
  }
}
