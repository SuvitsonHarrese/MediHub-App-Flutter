import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_hub/section/about_app.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({super.key});
  ///// Email URI
  final Uri _emailUri = Uri(
    scheme: 'mailto',
    path: 'suvitson17@gmail.com',
    query: encodeQueryParameters(
      <String, String>{
        'subject': 'About MediHuB App',
        'body': 'Hello developer, This app is ... ~Your Name(Not Necessary)',
      },
    ),
  );
  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  /// Launch the URL.
  Future<void> _launchUrl({required Uri uri}) async {
    // if (!await canLaunchUrl(uri)) {
    //   throw 'Could not launch $uri';
    // }

    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      color: Colors.greenAccent[200],
      padding: EdgeInsets.only(
        top: 24 + MediaQuery.of(context).padding.top,
        bottom: 24,
      ),
      child: Column(
        children: const [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 52,
            backgroundImage: AssetImage("lib/images/logo.png"),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'MediHuB',
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text("Logout"),
            onTap: () {
              // sign User out method
              FirebaseAuth.instance.signOut();
            },
          ),
          const Divider(
            color: Colors.black54,
          ),
          // ListTile(
          //   leading: Icon(Icons.handshake_outlined),
          //   title: Text("Support"),
          //   onTap: () => _launchUrl(uri: _emailUri),
          // ),
          // ListTile(
          //   leading: Icon(Icons.help_outline_sharp),
          //   title: Text("Help"),
          //   onTap: () { _launchUrl(uri: _emailUri);},
          // ),
          ListTile(
            leading: Icon(Icons.help_outline_sharp),
            title: Text("About App"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AboutApp(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback_outlined),
            title: Text("Feedback"),
            onTap: () {
              _launchUrl(uri: _emailUri);
            },
          )
        ],
      ),
    );
  }
}
