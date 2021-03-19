import 'package:buy_it_shop/provider/admin_mode.dart';
import 'package:buy_it_shop/model/modalhud.dart';
import 'package:buy_it_shop/screens/sighup_screen.dart';
import 'package:buy_it_shop/services/auth.dart';
import 'package:buy_it_shop/widgets/custom_textfield.dart';
import 'package:buy_it_shop/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:buy_it_shop/constant.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'admin_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  final adminPassword = 'admin123';

  final _auth = Auth();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isAdmin = false;
  String _email, _password;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            LogoWidget(),
            SizedBox(
              height: height * .08,
            ),
            CustomTextField(
              onClick: (Value) {
                _email = Value;
              },
              hint: 'Enter your email',
              icon: Icons.email,
            ),
            CustomTextField(
              onClick: (Value) {
                _password = Value;
              },
              hint: 'Enter your password',
              icon: Icons.lock,
            ),
            SizedBox(
              height: height * .15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 135),
              child: Builder(
                builder: (context) => FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () async {
                    _validate(context);
                  },
                  color: Colors.black,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * .05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an account ?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignupScreen.id);
                  },
                  child: Text(
                    ' Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Provider.of<AdminMode>(context, listen: false)
                          .changeIsAdmin(true);
                    },
                    child: Text(
                      "I'm an admin",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? kMainColor
                              : Colors.white),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Provider.of<AdminMode>(context, listen: false)
                          .changeIsAdmin(false);
                    },
                    child: Text(
                      "I'm an user",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? Colors.white
                              : kMainColor),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // هذي الفانكشن حتسوي تدقيق لمعلومات الحساب 
  //وتسجيل الدخول واذا كان الحساب حساب ادمن ام مستخدم عادي

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeIsLoading(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            await _auth.signIn(_email, _password);
            Navigator.pushNamed(context, AdminScreen.id);
          } catch (e) {
            modelhud.changeIsLoading(false);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          }
        } else {
          modelhud.changeIsLoading(false);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('you are not an admin')));
        }
      } else {
        try {
          await _auth.signIn(_email, _password);
          Navigator.pushNamed(context, HomePage.id);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
      
    }
    modelhud.changeIsLoading(false);
  }
}
