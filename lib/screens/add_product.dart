import '../model/product.dart';
import 'package:buy_it_shop/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:buy_it_shop/services/store.dart';
import '../constant.dart';


class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  final _store = Store();
  String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  shape:  RoundedRectangleBorder(
                    borderRadius:  BorderRadius.circular(30.0),
                  ),
                  elevation: 0,
                  color:kSecondaryColor,
                  child: Text('Add Product'),
                  onPressed: ()
                  {
                    if(_globalKey.currentState.validate())
                    {
                      _globalKey.currentState.save();

                      _store.addProduct(Product(
                        pName: _name,
                        pCategory: _category,
                        pDescription: _description,
                        pLocation: _imageLocation,
                        pPrice: _price,
                        

                      ));
                    }
                  },
                ),
                SizedBox(width: 40,),
                 RaisedButton(
                   shape:  RoundedRectangleBorder(
                    borderRadius:  BorderRadius.circular(20.0),
                  ),
                   elevation: 0,
                  color:kSecondaryColor,
                  child: Text('Add Product'),
                  onPressed: ()
                  {
                   
                      _globalKey.currentState.reset();
                    
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
