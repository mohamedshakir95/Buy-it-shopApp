import 'package:buy_it_shop/model/modalhud.dart';
import 'package:buy_it_shop/screens/home_page.dart';
import 'package:buy_it_shop/widgets/custom_textfield.dart';
import 'package:buy_it_shop/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:buy_it_shop/services/auth.dart';
import 'package:flutter/services.dart';
import '../constant.dart';
import 'login_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'SignupScreen';
  // ignore: unused_field
  String _email, _password,_name;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return  Scaffold(
        backgroundColor: kMainColor,
        body: ModalProgressHUD(
          inAsyncCall:Provider.of<ModelHud>(context).isLoading ,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: <Widget>[
                LogoWidget(),
                SizedBox(
                  height: height * .08,
                ),
                CustomTextField(
                  onClick: (Value) {
                    _name = Value;
                  },
                  hint: 'Enter your name',
                  icon: Icons.perm_identity,
                ),
                CustomTextField(
                  // ignore: non_constant_identifier_names
                  onClick: (Value) {
                    _email = Value;
                  },
                  hint: 'Enter your email',
                  icon: Icons.email,
                ),
                CustomTextField(
                  // ignore: non_constant_identifier_names
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
                    builder:(context) =>  FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () async {
                        final modelHud = Provider.of<ModelHud>(context , listen: false);
                        modelHud.changeIsLoading(true);
                        if (_globalKey.currentState.validate())
                         {
                          _globalKey.currentState.save();

                          try{
                          // ignore: unused_local_variable
                          final authResult = await _auth.signUp(
                            _email.trim(), _password.trim());
                          modelHud.changeIsLoading(false);
                          Navigator.pushNamed(context, HomePage.id);
                          } catch(e)
                          {
                            modelHud.changeIsLoading(false);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                e.message
                              )
                              
                            ));
                            
                          }
                        }
                       modelHud.changeIsLoading(false);

                      },
                      color: Colors.black,
                      child: Text(
                        'SignUp',
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
                      "Do have an account ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        ' Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    
  }
}
