import 'package:flutter/material.dart';
import 'package:food_app/widgets/meal_item.dart';

import '../data/dummy_data.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {

   static const routeName = '/category-meals';

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {


  String categoryTitle;
  List<Meal> displayMeals;
  var _loadedInitData = false;

  @override
  void initState() {

    super.initState();
  }


  @override
  void didChangeDependencies() {

    if(!_loadedInitData) {
      final routeArgs =
      ModalRoute.of(context).settings.arguments as Map<String, String>;

      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayMeals = DUMMY_MEALS.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();

      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }


  void _removeMeal(String mealId){
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text(
        categoryTitle
      ),),
      body: ListView.builder(itemBuilder: (ctx, index) {
            /// return Text(categoryMeals[index].title);
            return MealItem(
                id: displayMeals[index].id,
                title: displayMeals[index].title,
                imageUrl: displayMeals[index].imageUrl,
                duration: displayMeals[index].duration,
                affordability: displayMeals[index].affordability,
                complexity: displayMeals[index].complexity,
              removeItem: _removeMeal,
            );
      },
        itemCount: displayMeals.length,),
    );
  }
}
