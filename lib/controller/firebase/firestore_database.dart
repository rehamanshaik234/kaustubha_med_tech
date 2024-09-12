// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class FireStoreDB{
//   final FirebaseFirestore _fireStore= FirebaseFirestore.instance;
//
//   Future<String> addData(String collection,Map<String, dynamic> data)async{
//     try {
//       final docRef = await _fireStore.collection(collection).add(data);
//       return docRef.id;
//     } on Exception catch (e) {
//       print(e);
//       return "";
//     }
//   }
//
//   Future<bool> updateData(String collection,Map<String, dynamic> data,String id)async{
//     try {
//       await _fireStore.collection(collection).doc(id).update(data);
//       return true;
//     }catch(e){
//       print(e);
//       return false;
//     }
//   }
//
//   Future<bool> whereExist(String collection, Map<String, dynamic> data) async {
//     try {
//       Query<Map<String, dynamic>> collectionRef = _fireStore.collection(collection);
//
//       // Iterate over all key-value pairs in the map and apply 'where' conditions
//       data.forEach((key, value) {
//         if(value==null) {
//           collectionRef = collectionRef.where(key, isEqualTo: value);
//         }
//       });
//
//       // Execute the query with all 'where' conditions applied
//       var querySnapshot = await collectionRef.limit(1).get();
//
//       // Return true if at least one document exists
//       return querySnapshot.docs.isNotEmpty;
//     } catch (e) {
//       print(e);
//       return true;
//     }
//   }
//
//
// }