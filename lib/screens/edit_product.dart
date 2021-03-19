import 'package:buy_it_shop/constant.dart';
import 'package:buy_it_shop/model/product.dart';
import 'package:buy_it_shop/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buy_it_shop/services/store.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
//     List _products = [];
//     dynamic result;
//     fechProductsList() async {
//        result = await Store().loadProducts();

// print('length = ${result.length}');

//       if (result == null) {
//         print('unable to retrieve');
//       } else {
//         setState(() {
//           _products = result;
//         });
//       }

//     }

//     @override
//     void initState() {
//       super.initState();
//       fechProductsList();

//     }

//  print('length products = ${_products.length}');

    return Scaffold(
      appBar: AppBar(
        title: Text('kk'),
      ),
      backgroundColor: kMainColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data;
                products.add(Product(
                    pName: kProductName,
                    pPrice: kProductPrice,
                    pDescription: kProductDescription,
                    pLocation: kProductLocation,
                    pCategory: kProductCategory));
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                    itemCount: products.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Stack(
                    children: <Widget>[
                       Text(products[index].pName),
                      // Positioned.fill(
                      //   child: Image(
                      //     fit: BoxFit.fill,
                      //     image: AssetImage(products[index].pLocation),
                      //   ),
                      // ),
                      
                    ],
                  ),
                ),
              );
            }else {
              return Center(child: Text('Loading ...'));
            }
          }),
    );
  }
}

// body: StreamBuilder(
//     stream: FirebaseFirestore.instance
//         .collection(kProductsCollection)
//         .snapshots(),
//     builder: (context, snapshot) {
//       return ListView.builder(
//           itemCount: snapshot.data.docs.length,
//           itemBuilder: (context, index) {
//             DocumentSnapshot product = snapshot.data.docs[index];
//             return Column(
//               children: <Widget>[
//                 ListTile(
//                   title: Text(product[kProductName].toString()),
//                   subtitle: Text(product[kProductPrice].toString()),
//                 ),
//                 //           CustomTextField(
//                 //            onClick: (Value) {
//                 //           var _price = Value;
//                 // },),
//                 //Text((product[kProductName].toString()),)
//               ],
//             );
//           });
//     }),
