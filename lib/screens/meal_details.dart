import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({super.key, required this.meal});
  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      body: ListView(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  meal.imageUrl,
                  height: 300,
                  fit: BoxFit.cover,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 5,
          ),
          for (final ingredient in meal.ingredients)
            Text(
              ingredient,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
