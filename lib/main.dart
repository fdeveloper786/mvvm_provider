import 'package:flutter/material.dart';
import 'package:mvvm_practices/utils/routes/routes.dart';
import 'package:mvvm_practices/utils/routes/routes_names.dart';
import 'package:mvvm_practices/view_model/auth_view_model.dart';
import 'package:mvvm_practices/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MultiProvider(
       providers: [
         ChangeNotifierProvider(create: (_) => AuthViewModel()),
         ChangeNotifierProvider(create: (_) => UserViewModel()),
       ],
     child: MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'Flutter Demo',
     theme: ThemeData(
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
       useMaterial3: true,
     ),
     initialRoute: RoutesName.splash,
     onGenerateRoute: Routes.generateRoute,
   )
   );
  }
}

