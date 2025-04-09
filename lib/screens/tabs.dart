import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: const Color.fromARGB(255, 139, 42, 13),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          )),
    );
  }

  void _navigteToOnSelectScreen(String identifier) {
    Navigator.pop(context);
    if (identifier == 'filters') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  final List<Meal> _favouriteMeals = [];
  void _toggleSelectedFavroiteMeal(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favourite');
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
      _showInfoMessage('Meal is added to favourite');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavouriteMeal: _toggleSelectedFavroiteMeal,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavouriteMeal: _toggleSelectedFavroiteMeal,
      );
      activePageTitle = 'Your Favourite';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          activePageTitle,
        ),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      drawer: MainDrawer(
        onSelectScreen: _navigteToOnSelectScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(57, 240, 154, 148),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites')
        ],
      ),
    );
  }
}
