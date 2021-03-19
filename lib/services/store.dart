

import 'file:///C:/Users/mohamed/Desktop/AndroidStudioProjects/buy_it_shop/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buy_it_shop/constant.dart';

class Store {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //CollectionReference users = FirebaseFirestore.instance.collection(kProductsCollection);
  //dynamic list;
  //CollectionReference productsList = FirebaseFirestore.instance
  // .collection(kProductsCollection);

  addProduct(Product product) {
    _fireStore.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductDescription: product.pDescription,
      kProductLocation: product.pLocation,
      kProductCategory: product.pCategory
    });
  }
  //  Stream<QuerySnapshot> loadProducts(){
  //    return _fireStore.collection(kProductsCollection).snapshots();
  //  }
  // Product product;
  // Future<void> addProduct() async{
  //   return await productsList.doc(kProductsCollection)
  //   .set({kProductName : product.pName,
  //   kProductPrice : product.pPrice,
  //   kProductDescription : product.pDescription,
  //   kProductLocation : product.pLocation,
  //   kProductCategory : product.pCategory});

  // }

  Stream<List<Product>> loadProducts() async* {
    List<Product> products = [];
    var snapshots = _fireStore.collection(kProductsCollection).snapshots();
    QuerySnapshot query = await snapshots.first;
    List<QueryDocumentSnapshot> docs = query.docs;

    for (var doc in docs) {
      var data = doc.data();
      products.add(
        Product(
          pId: doc.id,
          pName: data[kProductName],
          pPrice: data[kProductPrice],
          pDescription: data[kProductDescription],
          pLocation: data[kProductLocation],
          pCategory: data[kProductCategory],
        ),
      );
    }
    yield products;
  }
  deleteProduct(documentId){
    _fireStore.collection(kProductsCollection).doc(documentId).delete();
  }
  
  editProduct(data , documentId){
   _fireStore.collection(kProductsCollection).doc(documentId).update(data);
  }

}
// QuerySnapshot snapShot = await _fireStore.collection(kProductsCollection).get();
//List itemList = [];
// try{
// await list.get().then((querySnapshot) {
//   querySnapshot.docs.forEach((element){
//     itemList.add(element.data);
//   print(itemList.length);

// });
// });
// return itemList;

// } catch(e){
//   print(e.toString());
//   return null;
// }

// }

// }
