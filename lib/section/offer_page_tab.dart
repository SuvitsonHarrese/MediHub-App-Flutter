import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_hub/components/grid_template.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyOfferPage extends StatefulWidget {
  const MyOfferPage({super.key});

  @override
  State<MyOfferPage> createState() => _MyOfferPageState();
}

final List<String> imgList = [
  'lib/images/1.png',
  'lib/images/2.png',
  'lib/images/3.png',
];

class _MyOfferPageState extends State<MyOfferPage>
    with AutomaticKeepAliveClientMixin<MyOfferPage> {
  // final String query;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    paginateData();
    controller.addListener(
      () {
        if (controller.position.pixels == controller.position.maxScrollExtent) {
          // isLoading=true;
          paginateData();
        }
      },
    );
    super.initState();
  }

  late TabController tb;

// Paginating firestore data
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot? lastDocument;
  int idx = 0;
  bool isMoreData = true;
  List<Map<String, dynamic>> list = [];
  // List<Map<String, dynamic>> result = [];
  final ScrollController controller = ScrollController();
  bool isLoading = false;

  void paginateData() async {
    if (isMoreData) {
      final collectionReference = _firestore.collection('Offers');
      late QuerySnapshot<Map<String, dynamic>> querySnapshot;

      if (lastDocument == null) {
        debugPrint("HELLO SIMP");
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

      list.addAll(querySnapshot.docs.map((e) => e.data()));

      debugPrint(list.length.toString());
      setState(() {});
      debugPrint("outside = ${querySnapshot.docs.length}");
      if (querySnapshot.docs.length < 10) {
        isMoreData = false;
        debugPrint("hello this is me");
        debugPrint("inside = ${querySnapshot.docs.length}");
      }
    } else {
      debugPrint("No  more  data");
    }
  }

// controller to keep tarck of which page we're on
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      controller: controller,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
            child: Text(
              "Offers from 1mg and Amazon",
              // softWrap: true,
              style: TextStyle(
                color: Colors.pink.shade700,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          CarouselSlider(
            items: imgList
                .map((item) => SizedBox(
                      child: Center(
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                          width: 1000,
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                  pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                });
              },
            ),
          ),
          // SmoothIndicator(offset: 50, count: 3),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: imgList.map(
          //     (e) {
          //       int index = imgList.indexOf(e);
          //       return Container(
          //         width: currentIndex == index ? 16 : 8,
          //         height: 8,
          //         margin:
          //             const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          //         decoration: BoxDecoration(
          //           shape: currentIndex == index
          //               ? BoxShape.rectangle
          //               : BoxShape.circle,
          //           borderRadius:
          //               currentIndex == index ? BorderRadius.circular(4) : null,
          //           color: currentIndex == index
          //               ? const Color.fromRGBO(0, 0, 0, 0.9)
          //               : const Color.fromRGBO(0, 0, 0, 0.4),
          //         ),
          //       );
          //     },
          //   ).toList(),
          // ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10),
              child: Text(
                "Best Seller in market",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GridView.builder(
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
                // print("simp");
              }
              var tmrp = list[index]['MRP'];
              var mrp = '₹ $tmrp';

              // if (query.isNotEmpty) {
              return GridViewTemplate(
                productID: list[index]['ID'],
                productName: list[index]['Product Name'],
                discount: list[index]['Discount'],
                rating: list[index]['Rating'],
                productPrice: productPrice,
                productLink: Uri.parse(list[index]['Product_Link']),
                avgStar: list[index]['Average Star'],
                mrp: mrp,
                productImageLink: list[index]['Product Image Link'],
                website: list[index]['Website'],
              );
              // }
              // return Container(
              //   child: CircularProgressIndicator(),
              // );
            },
            itemCount: list.length,
          ),
          list.length < 88
              ? SizedBox(
                  height: 75,
                  width: 75,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Center(
                      child: Image.asset("lib/images/loading.gif"),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
