import 'package:buy_it_shop/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buy_it_shop/constant.dart';
 class Store {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //CollectionReference users = FirebaseFirestore.instance.collection(kProductsCollection);
  //dynamic list;
  //CollectionReference productsList = FirebaseFirestore.instance
   // .collection(kProductsCollection);

    

  addProduct(Product product)
   {
   _fireStore.collection(kProductsCollection).add(
       {
         kProductName : product.pName,
         kProductPrice : product.pPrice,
         kProductDescription : product.pDescription,
         kProductLocation : product.pLocation,
         kProductCategory : product.pCategory
       }
     );
   }
   Stream<QuerySnapshot> loadProducts(){
     return _fireStore.collection(kProductsCollection).snapshots();
   }
   // Product product;
    // Future<void> addProduct() async{
    //   return await productsList.doc(kProductsCollection)
    //   .set({kProductName : product.pName,
    //   kProductPrice : product.pPrice,
    //   kProductDescription : product.pDescription,
    //   kProductLocation : product.pLocation,
    //   kProductCategory : product.pCategory});
      
    // }


  // Future<List<Product>>  loadProducts() async
  // {
  //   var list = await  _fireStore..collection(kProductsCollection).snapshots();
    // List<Product> products = [];
    // for(var doc in list.())
    // {
      // var data = doc.data;
      //  products.add(Product(
      //    pName: kProductCategory ,
      //      pPrice  :kProductPrice,
      //     pDescription : kProductDescription,
      //     pLocation : kProductLocation,
      //    pCategory : kProductCategory

      //    ));

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
}
   
    
    
   
  
  
  