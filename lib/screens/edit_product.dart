import 'package:buy_it_shop/constant.dart';
import 'file:///C:/Users/mohamed/Desktop/AndroidStudioProjects/buy_it_shop/product.dart';
import 'package:buy_it_shop/services/store.dart';
import 'package:buy_it_shop/widgets/custom_textfield.dart';
import 'package:buy_it_shop/widgets/snack_bar.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'manage_product.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  final _store = Store();
  String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              onClick: (Value) {
                _name = Value;
              },
              hint: 'Product Name',
            ),
            CustomTextField(
              onClick: (Value) {
                _price = Value;
              },
              hint: 'Product Price',
            ),
            CustomTextField(
              onClick: (Value) {
                _description = Value;
              },
              hint: 'Product Description',
            ),
            CustomTextField(
              onClick: (Value) {
                _category = Value;
              },
              hint: 'Product Category',
            ),
            CustomTextField(
              onClick: (Value) {
                _imageLocation = Value;
              },
              hint: 'Product Image Location',
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 0,
                  color: kSecondaryColor,
                  child: Text('Edit Product'),
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();

                      _store.editProduct(
                          ({
                            kProductName: _name,
                            kProductPrice: _price,
                            kProductCategory: _category,
                            kProductDescription: _description,
                            kProductLocation: _imageLocation
                          }),
                          product.pId);
                    }
                      
                    //CustomWidgets.buildErrorSnackbar(context,"Your message here");
                      
                      final snackBar = SnackBar(content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text("Product Edidet",
                        textAlign: TextAlign.start,
                         style: TextStyle(
                           fontWeight: FontWeight.bold , 
                          color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    behavior:SnackBarBehavior.floating ,
                      action: SnackBarAction(
                        label: 'Back To Products',
                        
                        textColor: Colors.black,
                      
                        onPressed: () {
                          Navigator.of(context).pushNamed(ManageProduct.id);
                        },
                      ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                      backgroundColor: kSecondaryColor,
                      duration: Duration(seconds: 5),
                     );
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                    

                      
                    //Navigator.of(context).pushNamed(ManageProduct.id);
                    
                  },
                ),
                SizedBox(
                  width: 40,
                ),
                 RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 0,
                  color: kSecondaryColor,
                  child: Text('Products Page'),
                  onPressed: (){
                    Navigator.of(context).pushNamed(ManageProduct.id);
                  },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
 
  // void showInSnackBar(String value) {
  //   Scaffold.of(context:_scaffoldKey.currentContext ).showSnackBar(new SnackBar(
  //       content: new Text(value)
  //   ));
}




