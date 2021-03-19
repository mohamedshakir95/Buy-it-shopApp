import 'package:buy_it_shop/model/modalhud.dart';
import 'package:buy_it_shop/screens/add_product.dart';
import 'package:buy_it_shop/screens/admin_screen.dart';
import 'package:buy_it_shop/screens/edit_product.dart';
import 'package:buy_it_shop/screens/manage_product.dart';
import 'package:buy_it_shop/screens/home_page.dart';
import 'package:buy_it_shop/screens/login_screen.dart';
import 'package:buy_it_shop/screens/sighup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'provider/admin_mode.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    
    return MultiProvider (
      providers:
      [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),)
      ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
          initialRoute: LoginScreen.id,
          routes: {
            LoginScreen.id: (context) => LoginScreen(),
            SignupScreen.id: (context) => SignupScreen(),
            HomePage.id: (context) => HomePage(),
            AdminScreen.id: (context) => AdminScreen(),
            AddProduct.id: (context) => AddProduct(),
            ManageProduct.id: (context) => ManageProduct(),
            EditProduct.id: (context) => EditProduct(),
          },
        ),
    );
  }
  
}
