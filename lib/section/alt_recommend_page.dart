// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:medicine_hub/components/grid_template.dart';
// import 'package:medicine_hub/components/search_bar.dart';
// import 'package:medicine_hub/record_model/product.dart';
// // import 'package:url_launcher/url_launcher.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   //list of product
//   List<Product> productDesciption = [];

//   // sign User out method
//   void signUserOut() {
//     FirebaseAuth.instance.signOut();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     // fetchRecords();
//     super.initState();
//   }

//   String query = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.deepPurple[100],
//       appBar: AppBar(
//         elevation: 0,
//         toolbarHeight: 70,
//         backgroundColor: Colors.deepPurple,
//         leading: IconButton(
//           onPressed: () {},
//           icon: Icon(Icons.account_circle_outlined),
//           iconSize: 40,
//         ),
//         centerTitle: true,
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(56),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
//             child: TextFormField(
//               onChanged: (value) => {
//                 setState(
//                   () {
//                     query = value;
//                   },
//                 ),
//               },
//               decoration: InputDecoration(
//                 hintText: "what are you looking for ?",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding: EdgeInsets.zero,
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: signUserOut,
//             iconSize: 40,
//             icon: Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('Product')
//             .where('Product Name', isGreaterThanOrEqualTo: query)
//             .where('Product Name', isLessThanOrEqualTo: '$query\uf8ff')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: const Text('Loading events...'),
//             );
//           }

//           //  Grid View Builder

//           return GridView.builder(
//             padding: EdgeInsets.only(top: 15, left: 10, right: 10),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisExtent: 315,
//                 mainAxisSpacing: 10),
//             itemBuilder: (BuildContext context, int index) {

//               // Converting  string
//               var text = snapshot.data!.docs[index]['Price'];
//               var productPrice = text.replaceAll('?', '₹');

//               if (query.isNotEmpty) {
//                 return GridViewTemplate(
//                   productName: snapshot.data!.docs[index]['Product Name'],
//                   discount: snapshot.data!.docs[index]['Discount'],
//                   rating: snapshot.data!.docs[index]['Rating'],
//                   productPrice: productPrice,
//                 );
//               }
//               if(query.isEmpty){
//                 return GridViewTemplate(
//                   productName: snapshot.data!.docs[index]['Product Name'],
//                   discount: snapshot.data!.docs[index]['Discount'],
//                   rating: snapshot.data!.docs[index]['Rating'],
//                   productPrice: productPrice,
//                 );
//               }
//               return Container(
//                 child: CircularProgressIndicator(),
//               );
//             },
//             itemCount: snapshot.data.docs.length,
//           );
//         },
//       ),
//     );
//   }
// }
