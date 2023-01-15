import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_hub/components/grid_template.dart';

class RecommendTab extends StatefulWidget {
  final TextEditingController control;
  const RecommendTab({super.key, required this.control});

  @override
  State<RecommendTab> createState() => _RecommendTabState();
}

class _RecommendTabState extends State<RecommendTab>
    with AutomaticKeepAliveClientMixin<RecommendTab> {
  String last = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paginateData();
    widget.control.addListener(
      () {
        if (last != widget.control.text && widget.control.text.isNotEmpty) {
          result.clear();
          setState(() {
            idx = 0;
            query = widget.control.text;
            last = query;
            searchPaginateData();
          });
        }
        if (widget.control.text.isEmpty) {
          setState(() {
          query = "";
          last = "";
          result.clear();
            
          });
        }
        debugPrint('kbjksjbdkgbdg   kauhdfkg ${widget.control.text}');
      },
    );
    controller.addListener(
      () async {
        if (controller.position.pixels == controller.position.maxScrollExtent) {
          debugPrint("________________________________________________NiCe la");
          if (result.isEmpty && query.isEmpty) {
            debugPrint("___________________________________________Super Bad");
            await Future.delayed(Duration(milliseconds: 1700));
            paginateData();
          } else {
            if (mutex) {
              searchPaginateData();
            }else{
              debugPrint("________________________________________bRotHeR");
            }
          }
          debugPrint("he dear");
        }
      },
    );
  }

// Paginating firestore data
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot? lastDocument;
  int idx = 0;
  bool isMoreData = true;
  List<Map<String, dynamic>> list = [];
  List<Map<String, dynamic>> result = [];
  final ScrollController controller = ScrollController();
  bool isLoading = false;
  bool mutex = true;
  // bool once = true;

  void paginateData() async {
    if (isMoreData) {
      final collectionReference = _firestore.collection('Product');
      late QuerySnapshot<Map<String, dynamic>> querySnapshot;

      if (lastDocument == null) {
        querySnapshot =
            await collectionReference.orderBy('Product Name').limit(10).get();
        debugPrint("NEWSIMP");
      } else {
        querySnapshot = await collectionReference
            .orderBy('Product Name')
            .limit(10)
            .startAfterDocument(lastDocument!)
            .get();
      }
      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
      }

      debugPrint("Middle");
      list.addAll(querySnapshot.docs.map((e) => e.data()));
      // await Future.delayed(Duration(milliseconds: 1500));

      debugPrint(list.length.toString());
      setState(() {});
      debugPrint("outside query length= ${querySnapshot.docs.length}");
      if (querySnapshot.docs.length < 10) {
        isMoreData = false;
        debugPrint("hello this is me");
        debugPrint("inside = ${querySnapshot.docs.length}");
      }
    } else {
      debugPrint("No  more  data");
    }
  }

  void searchPaginateData() async {
    if (isMoreData) {
      mutex = false;
      setState(() {
        isLoading = true;
      });

      final collectionReference = _firestore.collection('Product');
      late QuerySnapshot<Map<String, dynamic>> querySnapshot;

      if (lastDocument == null) {
        debugPrint("Search with last document equal to null");
        debugPrint("NEWSIMP");
        querySnapshot =
            await collectionReference.orderBy('Product Name').limit(10).get();
      } else {
        querySnapshot = await collectionReference
            .orderBy('Product Name')
            .limit(10)
            .startAfterDocument(lastDocument!)
            .get();
      }
      lastDocument = querySnapshot.docs.last;
      debugPrint("hello boi this is last doc la  ${lastDocument!.data()}");

      list.addAll(querySnapshot.docs.map((e) => e.data()));
      if (result.isNotEmpty) {
        await Future.delayed(Duration(milliseconds: 1800));
      }

      debugPrint("index = ${list.length - querySnapshot.docs.length}");
      debugPrint("list length = ${list.length}");
      debugPrint("docs length = ${querySnapshot.docs.length}");

      for (int i = idx; i < list.length; i++) {
        if (list[i]['Product Name']
            .toString()
            .toLowerCase()
            .startsWith(query.toLowerCase())) {
          result.add(list[i]);
        }
      }
      idx = list.length;
      isLoading = false;

      debugPrint("result = ${result.length}");
      setState(() {});
      debugPrint("search outside = ${querySnapshot.docs.length}");
      if (querySnapshot.docs.length < 10) {
        isMoreData = false;
        debugPrint("hello search this is me");
        debugPrint("search inside = ${querySnapshot.docs.length}");
      }
      if (result.length < 4) {
        searchPaginateData();
        debugPrint("result len is less than 4  = ${result.length}");
      }else{
        mutex=true;
      }
      // else {
      //   searchPaginateData();
      // }
    } else {
      mutex=true;
      debugPrint("No  more  search data");
      for (int i = idx; i < list.length; i++) {
        if (list[i]['Product Name']
            .toString()
            .toLowerCase()
            .startsWith(query.toLowerCase())) {
          result.add(list[i]);
        }
        debugPrint(
            list[i]['Product Name'] + "  oure search  ID :  " + list[i]['ID']);
        debugPrint(i.toString());

        /// For Collecting img URL from Cloud Storage and storing it in firestore
        ///
        ///
        // final collectionReference = _firestore.collection('Offers');
        // if (list[i]['Website'] == 'Amazon') {
        //   String str = await _storage
        //       .ref('amazon_product/${list[i]['ID']}.jpg')
        //       .getDownloadURL();
        //   debugPrint(str);

        //   collectionReference
        //       .doc(list[i]['ID'])
        //       .set({'Product Image Link': str}, SetOptions(merge: true));
        //   once = false;
        //   debugPrint(list[i]['Product Name'] + "simp");
        //   debugPrint(i.toString());
        // }
      }
    }
  }

  String query = "";

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      controller: controller,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        children: [
          query.isEmpty
              ? GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // controller: controller,
                  padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 330,
                      mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int index) {
                    // Converting  string
                    var text = list[index]['Price'];
                    var productPrice = text.replaceAll('?', '₹');
                    if (productPrice.indexOf("₹") == -1) {
                      productPrice = '₹ $productPrice';
                    }

                    // debugPrint("LIST RESULT LEN_____________________________________________BRO ${result.length}");
                    var tmrp = list[index]['MRP'];
                    var mrp = '₹ $tmrp';

                    // if(isLoading) return CircularProgressIndicator();

                    // if (query.isEmpty) {
                    return GridViewTemplate(
                      productName: list[index]['Product Name'],
                      discount: list[index]['Discount'],
                      rating: list[index]['Rating'],
                      productPrice: productPrice,
                      productLink: Uri.parse(list[index]['Product_Link']),
                      avgStar: list[index]['Average Star'],
                      mrp: mrp,
                      productImageLink: list[index]['Product Image Link'],
                      website: list[index]['Website'],
                      productID: list[index]['ID'],
                    );
                    // }
                    // return Center(
                    //   child: CircularProgressIndicator(),
                    // );
                  },
                  itemCount: list.length,
                )
              : GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // controller: controller,
                  padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 330,
                      mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int index) {
                    // Converting  string
                    var text = result[index]['Price'];
                    var productPrice = text.replaceAll('?', '₹');
                    if (productPrice.indexOf("₹") == -1) {
                      productPrice = '₹ $productPrice';
                      // print("simp");
                    }
                    var tmrp = list[index]['MRP'];
                    var mrp = '₹ $tmrp';

                    return GridViewTemplate(
                      productID: result[index]['ID'],
                      productName: result[index]['Product Name'],
                      discount: result[index]['Discount'],
                      rating: result[index]['Rating'],
                      productPrice: productPrice,
                      productLink: Uri.parse(result[index]['Product_Link']),
                      avgStar: result[index]['Average Star'],
                      mrp: mrp,
                      productImageLink: result[index]['Product Image Link'],
                      website: result[index]['Website'],
                    );
                  },
                  itemCount: result.length,
                ),
          result.isEmpty && list.length >= 101 && query.isNotEmpty
              ? Text("No Result Found !!!")
              : SizedBox(),
          // Consumer<Loader>(
          //   builder: (context, Loader, child) {
          //     return isLoading
          //         ? SizedBox(
          //             height: 100,
          //             width: 100,
          //             child: Center(child: CircularProgressIndicator()),
          //           )
          //         : SizedBox();
          //   },
          // ),
          // ValueListenableBuilder(
          //   builder: (_, myProvider, child) {
          //     return myProvider
          //         ? SizedBox(
          //             // height: 100,
          //             // width: 100,
          //             child: Center(child: CircularProgressIndicator()),
          //           )
          //         : SizedBox();
          //   },
          //   valueListenable: load,
          // ),
          list.length < 101 && query.isEmpty
              ? SizedBox(
                  height: 75,
                  width: 75,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Center(
                      child: Image.asset("lib/images/loading.gif",height: 75,width: 75,),
                    ),
                  ),
                )
              : SizedBox(),
          isLoading
              ? SizedBox(
                  height: 75,
                  width: 75,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Center(
                      child: Image.asset("lib/images/loading.gif",height: 75,width: 75,),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

