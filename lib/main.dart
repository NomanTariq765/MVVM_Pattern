import 'package:flutter/material.dart';
import 'package:mvvm_model/utils/routes/routes.dart';
import 'package:mvvm_model/view/login_view.dart';
import 'package:mvvm_model/view_model/auth_view_model.dart';
import 'package:mvvm_model/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import 'utils/routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>AuthViewModel()),
      ChangeNotifierProvider(create: (_)=>UserViewModel()),

    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
    ),
    );
  }
}



