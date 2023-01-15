import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_hub/components/drawer_nav.dart';
import 'package:medicine_hub/section/offer_page_tab.dart';
import 'package:medicine_hub/section/recommend_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // sign User out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  ////////// Tab bar
  late TabController tb;

  @override
  void initState() {
    // TODO: implement initState
    tb = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
    checkRealtimeConnection();
    tb.addListener(
      () {
        if (tb.index == 0) {
          setState(() {
            slide = true;
          });
        } else {
          setState(() {
            slide = false;
          });
        }
      },
    );
  }

  bool hasInternet = false;
  bool slide = true;
  final ScrollController controller = ScrollController();
  final TextEditingController control = TextEditingController();
  final Connectivity connectivity = Connectivity();
  late StreamSubscription streamSubscription;

  // RealTime Connectivity
  void checkRealtimeConnection() {
    streamSubscription = connectivity.onConnectivityChanged.listen(
      (event) {
        debugPrint("_________________________________________Bro am listening");
        if (event == ConnectivityResult.mobile ||
            event == ConnectivityResult.wifi) {
          hasInternet = true;
          setState(() {});
        } else {
          hasInternet = false;
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamSubscription.cancel();
    super.dispose();
  }

  // String query = "";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.deepPurple[100],
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 70,
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                    child: TextFormField(
                      enabled: slide,
                      controller: control,
                      // // focusNode: FocusNode(),
                      // onChanged: (value) => {
                      //   if (value != query)
                      //     {
                      //       setState(
                      //         () {
                      //           query = value;
                      //           // result.clear();
                      //           // idx = 0;
                      //           // searchPaginateData();
                      //           // debugPrint("Vera yaru nanthan ^O ");
                      //         },
                      //       ),
                      //     }
                      // },
                      decoration: InputDecoration(
                        hintText: "what are you looking for ?",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        // suffixIcon:
                        //     IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.white70,
                    controller: tb,
                    tabs: const <Widget>[
                      Tab(
                        child: Text("Recommended"),
                      ),
                      Tab(
                        child: Text("Offers"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: signUserOut,
                iconSize: 30,
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          body: TabBarView(
            controller: tb,
            children: <Widget>[
              hasInternet
                  ? RecommendTab(
                      control: control,
                    )
                  : Image.asset(
                      "lib/images/noInternetConnection.gif",
                      height: 600,
                    ),
              hasInternet
                  ? MyOfferPage()
                  : Image.asset("lib/images/noInternetConnection.gif"),
            ],
          ),
          drawer: NavigationDrawer(),
        ),
      ),
    );
  }
}
