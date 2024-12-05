import 'package:flutter/material.dart';
import 'package:person/home_page.dart';
import 'package:person/person.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const HomePage(),
    );
  }
}







// class DetailsPage extends StatelessWidget {
//   final Person person;

//   const DetailsPage({
//     super.key,
//     required this.person,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Hero(
//           flightShuttleBuilder: (
//               flightContext,
//               animation,
//               flightDirection,
//               fromHeroContext,
//               toHeroContext,
//               ) {
//             switch (flightDirection) {
//               case HeroFlightDirection.push:
//                 return Material(
//                   color: Colors.transparent,
//                   child: ScaleTransition(
//                     scale: animation.drive(
//                       Tween<double>(
//                         begin: 0.0,
//                         end: 1.0,
//                       ).chain(
//                         CurveTween(
//                           curve: Curves.fastOutSlowIn,
//                         ),
//                       ),
//                     ),
//                     child: toHeroContext.widget,
//                   ),
//                 );
//               case HeroFlightDirection.pop:
//                 return Material(
//                   color: Colors.transparent,
//                   child: fromHeroContext.widget,
//                 );
//             }
//           },
//           tag: person.name,
//           child: Text(
//             person.emoji,
//             style: const TextStyle(
//               fontSize: 50,
//             ),
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             Text(
//               person.name,
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               '${person.age} years old',
//               style: const TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }