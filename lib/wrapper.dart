import 'package:calorun/screens/authenticate/authenticate.dart';
import 'package:calorun/screens/authenticate/prelogin.dart';
import 'package:calorun/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calorun/screens/home/home_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String user = Provider.of<String>(context);
    if (user == null) {
      return Prepage();
    } else {
      return Home();
    }
  }
}

// class Wrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Replace the 3 second delay with your initialization code:
      
//       builder: (context, AsyncSnapshot snapshot) {
//         // Show splash screen while waiting for app resources to load:
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return MaterialApp(home: Waiting());
//         } else {
//           // Loading is done, return the app:
//           return MaterialApp(
//             home: Home(),
//           );
//         }
//       },
//     );
//   }
// }

// class Splash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Icon(
//           Icons.apartment_outlined,
//           size: MediaQuery.of(context).size.width * 0.785,
//         ),
//       ),
//     );
//   }
// }