import 'package:flutter/material.dart';
import 'dart:async'; // Import for Timer

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ScrollController> _scrollControllers = [];
  List<ScrollController> _fruitScrollControllers = [];
  List<Timer?> _timers = [];

  @override
  void initState() {
    super.initState();
    _initScrollControllers();
    _startScrolling();
  }

  void _initScrollControllers() {
    for (int i = 0; i < 2; i++) {
      _scrollControllers.add(ScrollController());
      _fruitScrollControllers.add(ScrollController());
    }
  }

  void _startScrolling() {
    for (int i = 0; i < _scrollControllers.length; i++) {
      _timers.add(Timer.periodic(const Duration(milliseconds: 30), (timer) {
        if (_scrollControllers[i].position.pixels < _scrollControllers[i].position.maxScrollExtent) {
          _scrollControllers[i].jumpTo(_scrollControllers[i].position.pixels + 0.5);
        } else {
          _scrollControllers[i].jumpTo(0); // Reset to the beginning
        }
        if (_fruitScrollControllers[i].position.pixels < _fruitScrollControllers[i].position.maxScrollExtent) {
          _fruitScrollControllers[i].jumpTo(_fruitScrollControllers[i].position.pixels + 0.5);
        } else {
          _fruitScrollControllers[i].jumpTo(0); // Reset to the beginning
        }
      }));
    }
  }

  @override
  void dispose() {
    for (var controller in _scrollControllers) {
      controller.dispose(); // Dispose each ScrollController
    }
    for (var controller in _fruitScrollControllers) {
      controller.dispose(); // Dispose each ScrollController
    }
    for (var timer in _timers) {
      timer?.cancel(); // Cancel the timers
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People & Fruits'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Uniform padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Great Everyday Picks
              const Text(
                'Great Everyday Picks',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16), // Small gap
              
              // People List inside gradient background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.5),
                      Colors.purple.withOpacity(0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10), // Padding inside card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Complete and Conquer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 100, // Adjust height for people list
                      child: PeopleListWidget(scrollControllers: _scrollControllers),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16), // 16dp gap as requested

              // Section 2: Discover Foods
              const Text(
                'Discover Foods',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16), // Small gap

              // Fruit List inside gradient background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.5),
                      Colors.orange.withOpacity(0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10), // Padding inside card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Our Favourites',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 100, // Adjust height for fruit list
                      child: FruitListWidget(scrollControllers: _fruitScrollControllers),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// People List Widget
class PeopleListWidget extends StatelessWidget {
  final List<ScrollController> scrollControllers;

  const PeopleListWidget({
    Key? key,
    required this.scrollControllers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollControllers[0],
      scrollDirection: Axis.horizontal,
      itemCount: people.length,
      itemBuilder: (context, index) {
        final person = people[index];
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 90,
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  person.emoji,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 5),
                Text(
                  person.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Fruit List Widget
class FruitListWidget extends StatelessWidget {
  final List<ScrollController> scrollControllers;

  const FruitListWidget({
    Key? key,
    required this.scrollControllers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollControllers[0],
      scrollDirection: Axis.horizontal,
      itemCount: fruits.length,
      itemBuilder: (context, index) {
        final fruit = fruits[index];
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 90,
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  fruit.emoji,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 5),
                Text(
                  fruit.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Person class
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}

// Fruit class
class Fruit {
  final String name;
  final String emoji;

  const Fruit({
    required this.name,
    required this.emoji,
  });
}

// Dummy data for people
final List<Person> people = [
  Person(name: 'John', age: 20, emoji: '🙋🏻‍♂️'),
  Person(name: 'Jane', age: 21, emoji: '👸🏽'),
  Person(name: 'Jack', age: 22, emoji: '🧔🏿‍♂️'),
  Person(name: 'Alice', age: 23, emoji: '👩🏻‍🎤'),
  Person(name: 'Bob', age: 24, emoji: '👨🏼‍⚖️'),
  Person(name: 'Charlie', age: 25, emoji: '🧑🏽‍🦱'),
  Person(name: 'Diana', age: 26, emoji: '👩🏾‍🦰'),
  Person(name: 'Ethan', age: 27, emoji: '👨🏽‍🎓'),
  Person(name: 'Fiona', age: 28, emoji: '👩🏽‍🏫'),
  Person(name: 'George', age: 29, emoji: '👨🏿‍🔧'),
  Person(name: 'Hannah', age: 30, emoji: '👩🏼‍🍳'),
  Person(name: 'Ian', age: 31, emoji: '👨🏻‍💼'),
  Person(name: 'Jasmine', age: 32, emoji: '👩🏾‍⚕️'),
  Person(name: 'Kevin', age: 33, emoji: '👨🏽‍🏭'),
  Person(name: 'Laura', age: 34, emoji: '👩🏻‍🎨'),
];

// Dummy data for fruits
final List<Fruit> fruits = [
  Fruit(name: 'Apple', emoji: '🍎'),
  Fruit(name: 'Banana', emoji: '🍌'),
  Fruit(name: 'Cherry', emoji: '🍒'),
  Fruit(name: 'Grapes', emoji: '🍇'),
  Fruit(name: 'Mango', emoji: '🥭'),
  Fruit(name: 'Orange', emoji: '🍊'),
  Fruit(name: 'Peach', emoji: '🍑'),
  Fruit(name: 'Pineapple', emoji: '🍍'),
];

