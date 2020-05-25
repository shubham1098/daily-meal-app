import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealScreen(this.availableMeals);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
     if(!_loadedInitData) {
       final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
        categoryTitle = routeArgs['title'];
        final categoryId = routeArgs['id'];
        displayMeals = widget.availableMeals.where((meal) {
          return meal.categories.contains(categoryId);
        }).toList();
        _loadedInitData = true;
     }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeals[index].id,
            title: displayMeals[index].title,
            imageUrl: displayMeals[index].imageUrl,
            affordability: displayMeals[index].affordability,
            duration: displayMeals[index].duration,
            complexity: displayMeals[index].complexity,
          );
        },
        itemCount: displayMeals.length,
      ),
    );
  }
}
