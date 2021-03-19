import 'package:buy_it_shop/constant.dart';
import 'package:buy_it_shop/screens/add_product.dart';
import 'file:///C:/Users/mohamed/Desktop/AndroidStudioProjects/buy_it_shop/product.dart';
import 'package:buy_it_shop/services/auth.dart';
import 'package:buy_it_shop/services/store.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth(); 
  //FirebaseUser _loggedUser();
  int _tabBarIndex = 0;
  final _store = Store();
  int _bottomBarIndex = 0;
  List<Product> _products;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _bottomBarIndex,
              fixedColor: kMainColor,
              onTap: (value) {
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                  title: Text('Test'),
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  title: Text('Test'),
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  title: Text('Test'),
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  title: Text('Test'),
                  icon: Icon(Icons.person),
                ),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
    
                isScrollable: false,
                
                  indicatorColor: kMainColor,
                  onTap: (value) {
                    setState(() {
                      _tabBarIndex = value;
                    });
                  },
                  tabs: <Widget>[
                    Text(
                      'Jackets',
                      style: TextStyle(
                        color:
                            _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                        fontSize: _tabBarIndex == 0 ? 16 : null,
                      ),
                    ),
                    Text(
                      'Trouser',
                      style: TextStyle(
                          color:
                              _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                          fontSize: _tabBarIndex == 1 ? 16 : null),
                    ),
                    Text(
                      'T-shirts',
                      style: TextStyle(
                          color:
                              _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                          fontSize: _tabBarIndex == 2 ? 16 : null),
                    ),
                    Text(
                      'Shoes',
                      style: TextStyle(
                          color:
                              _tabBarIndex == 3 ? Colors.black : kUnActiveColor,
                          fontSize: _tabBarIndex == 3 ? 16 : null),
                    ),
                  ]),
                
            ),
            body: TabBarView(
             
              children: <Widget>[
                jacketView(),
                trousers(),
                tShirts(),
                shoes(),
               //  productView(kTrousers),
                // productView(kTshirts),
                // productView(kShoes),
                //productView(kTshirts),
                //productView(kShoes),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.shopping_cart)
                ],
              ),
            ),
          ),
        ),
       ],
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentUser();
  // }

  // getCurrentUser() async {
  //   //_loggedUser = await _auth.getUser();
  // }

  Widget jacketView() {
    return StreamBuilder<List<Product>>(
        stream: Store().loadProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var products = snapshot.data;
              _products = [...products];
              products.clear();
              products = getProductsByCategory(kJackets);
              return Container(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: .8),
                    itemCount: products.length,
                    itemBuilder: (context, index) => Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                          child: GestureDetector(
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
                                      width: MediaQuery.of(context).size.width,
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
                                                  fontWeight: FontWeight.bold),
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
          return Container(
            child: Text('error'),
          );
        });
  }

  List<Product> getProductsByCategory(String kJackets) {
    List<Product> products = [];
    for (var product in _products) {
      if (product.pCategory == kJackets) {
        products.add(product);
      }
    }
    return products;
  }

 Widget trousers() {
    return StreamBuilder<List<Product>>(
        stream: Store().loadProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var products = snapshot.data;
              _products = [...products];
              products.clear();
              products = getProductsByCategory(kTrousers);
              return Container(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: .8),
                    itemCount: products.length,
                    itemBuilder: (context, index) => Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                          child: GestureDetector(
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
                                      width: MediaQuery.of(context).size.width,
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
                                                  fontWeight: FontWeight.bold),
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
          return Container(
            child: Text('error'),
          );
        });
  }

 Widget tShirts() {
    return StreamBuilder<List<Product>>(
        stream: Store().loadProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var products = snapshot.data;
              _products = [...products];
              products.clear();
              products = getProductsByCategory(kTshirts);
              return Container(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: .8),
                    itemCount: products.length,
                    itemBuilder: (context, index) => Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                          child: GestureDetector(
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
                                      width: MediaQuery.of(context).size.width,
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
                                                  fontWeight: FontWeight.bold),
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
          return Container(
            child: Text('error'),
          );
        });
  }
  
 Widget shoes() {
    return StreamBuilder<List<Product>>(
        stream: Store().loadProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var products = snapshot.data;
              _products = [...products];
              products.clear();
              products = getProductsByCategory(kShoes);
              return Container(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: .8),
                    itemCount: products.length,
                    itemBuilder: (context, index) => Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                          child: GestureDetector(
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
                                      width: MediaQuery.of(context).size.width,
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
                                                  fontWeight: FontWeight.bold),
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
          return Container(
            child: Text('error'),
          );
        });
  }
  
  
  // Widget productView( String pCategory) {
  //   List<Product> products = [];
  //   products = getProductsByCategory(pCategory);
  //   return GridView.builder(
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 2, childAspectRatio: .8),
  //       itemCount: products.length,
  //       itemBuilder: (context, index) => Padding(
  //             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
  //             child: GestureDetector(
  //               child: Stack(
  //                 children: <Widget>[
  //                   Positioned.fill(
  //                     child: Image(
  //                       fit: BoxFit.fill,
  //                       image: AssetImage(products[index].pLocation),
  //                     ),
  //                   ),
  //                   Positioned(
  //                     bottom: 0,
  //                     child: Opacity(
  //                       opacity: .6,
  //                       child: Container(
  //                         width: MediaQuery.of(context).size.width,
  //                         height: 60,
  //                         color: Colors.white,
  //                         child: Padding(
  //                           padding: EdgeInsets.symmetric(
  //                               vertical: 5, horizontal: 10),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: <Widget>[
  //                               Text(
  //                                 products[index].pName,
  //                                 style: TextStyle(fontWeight: FontWeight.bold),
  //                               ),
  //                               Text('\$ ${products[index].pPrice}'),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ));
  // }



}
