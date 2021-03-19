import 'package:buy_it_shop/constant.dart';
import 'package:flutter/material.dart';

import 'add_product.dart';
import 'edit_product.dart';
import 'manage_product.dart';

class AdminScreen extends StatelessWidget {
  static String id = 'AdminScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity ,
          ),
          RaisedButton(              
                  
            onPressed: ()
            {
              Navigator.of(context).pushNamed(AddProduct.id);
            },
            child: Text('Add Product'),
          ),
          RaisedButton(
            onPressed: ()
            {
              Navigator.of(context).pushNamed(ManageProduct.id);

            },
            child: Text('Manage Product'),
          ),
          RaisedButton(
            onPressed: ()
            {

            },
            child: Text('View Product'),
          ),
        ],
        
      ),
    );
  }
}