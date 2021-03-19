

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:buy_it_shop/constant.dart';
import 'file:///C:/Users/mohamed/Desktop/AndroidStudioProjects/buy_it_shop/product.dart';
import 'package:buy_it_shop/services/store.dart';
import 'package:buy_it_shop/widgets/custom_textfield.dart';

import 'add_product.dart';
import 'edit_product.dart';

class ManageProduct extends StatefulWidget {
  static String id = 'ManageProduct';

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _store = Store();
  List<Product> _product = [];

  //GlobalKey _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffold,
      backgroundColor: kMainColor,
      body: StreamBuilder<List<Product>>(
          stream: Store().loadProducts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var products = snapshot.data;
                return Container(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: .8),
                      itemCount: products.length,
                      itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 7),
                            child: GestureDetector(
                              onTapUp: (details) {
                                double dx = details.globalPosition.dx;
                                double dy = details.globalPosition.dy;
                                double dx2 =
                                    MediaQuery.of(context).size.width - dx;
                                double dy2 =
                                    MediaQuery.of(context).size.width - dy;
                                showMenu(
                                    context: context,
                                    position:
                                        RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                                    items: [
                                      MyPopupMenuItem(
                                        onClick: () {
                                          Navigator.of(context)
                                              .pushNamed(EditProduct.id,arguments: products[index]);
                                        },
                                        child: Text('Edit'),
                                      ),
                                      MyPopupMenuItem(
                                        onClick: () {
                                          _store.deleteProduct(products[index].pId);
                                          //Navigator.of(context).pushNamed(ManageProduct.id);
                                          setState(() {
                                            //Store().loadProducts();
                                          });
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ]);
                              },
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: Image(
                                      fit: BoxFit.fill,
                                      image:
                                          AssetImage(products[index].pLocation),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Opacity(
                                      opacity: .6,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                products[index].pName,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  '\$ ${products[index].pPrice}'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                );
              }
            }
            return Container();
          }),
    );
  }
}

class MyPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;
  MyPopupMenuItem({
    @required this.onClick,
    @required this.child,
  }) : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
// void gitProducts() async{
//   _product = await _store.loadProducts();
// }
//  @override
// void initState() {
//   super.initState();
//   gitProducts();
// }

//   return Scaffold(
//     appBar: AppBar(
//       title: Text('kk'),
//     ),
//     backgroundColor: kMainColor,
//     body: StreamBuilder<QuerySnapshot>(
//         stream: _store.loadProducts(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<Product> products = [];
//             for (var doc in snapshot.data.docs) {
//               var data = doc.data;
//               products.add(Product(
//                   pName: kProductName,
//                   pPrice: kProductPrice,
//                   pDescription: kProductDescription,
//                   pLocation: kProductLocation,
//                   pCategory: kProductCategory));
//             }
//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2),
//                   itemCount: products.length,
//               itemBuilder: (context, index) => Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 child: Stack(
//                   children: <Widget>[
//                      Text(products[index].pName),
//                     // Positioned.fill(
//                     //   child: Image(
//                     //     fit: BoxFit.fill,
//                     //     image: AssetImage(products[index].pLocation),
//                     //   ),
//                     // ),

//                   ],
//                 ),
//               ),
//             );
//           }else {
//             return Center(child: Text('Loading ...'));
//           }
//         }),
//   );
// }

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
