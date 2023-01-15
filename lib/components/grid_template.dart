// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GridViewTemplate extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String discount;
  final String rating;
  final Uri productLink;
  final String avgStar;
  final String mrp;
  final String productID;
  final String productImageLink;
  final String website;
  const GridViewTemplate({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.discount,
    required this.rating,
    required this.productLink,
    required this.avgStar,
    required this.mrp,
    required this.productImageLink,
    required this.website,
    required this.productID,
  });

  @override
  Widget build(BuildContext context) {
    // debugPrint(productID);

    return GestureDetector(
      // onTap: () => {
      //   showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: Text("Link ila la mahiru"),
      //       );
      //     },
      //   ),
      // },

      onTap: () async {
        debugPrint("Nice bro");
        await launchUrl(
          productLink,
          mode: LaunchMode.externalApplication,
          webViewConfiguration: WebViewConfiguration(
            enableJavaScript: true,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            16.0,
          ),
          color: Colors.purple.shade50,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    productImageLink,
                    height: 170,
                    // width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Divider(height: 1,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    // color: Colors.white,
                    child: Text(
                      productName,
                      style: Theme.of(context).textTheme.subtitle1!.merge(
                            const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),

                  ///////////////////////////////////////  Star Rating

                  Row(
                    children: [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFF1AAB2A),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Center(
                                child: Text(
                                  avgStar,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              // ClipPath(
                              //   clipper: StarClipper(5),
                              //   child: Container(
                              //     height: 20,
                              //     width: 20,
                              //     color: Colors.amber.shade100,
                              //   ),
                              // )
                              Icon(Icons.star_purple500_sharp,color: Colors.amber.shade100,size: 20,)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        rating,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 25,
                    child: Row(
                      children: [
                        Text("MRP "),
                        Text(
                          mrp,
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          discount,
                          style: TextStyle(
                              color: Colors.green[600],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        // color: Colors.white,
                        width: 110,
                        child: Text(
                          productPrice,
                          style: Theme.of(context).textTheme.subtitle2!.merge(
                                TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      website == "1mg"
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.asset(
                                "lib/images/1mg.png",
                                height: 20,
                              ),
                            )
                          : CircleAvatar(
                              // radius: 13,
                              backgroundColor: Colors.white,
                              // backgroundImage: AssetImage("lib/images/amy.png", ),
                              child: Image.asset("lib/images/amazon.png",
                                  height: 36),
                            )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
