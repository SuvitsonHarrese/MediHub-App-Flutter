import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      //   elevation: 0,
      //   toolbarHeight: 70,
      //   backgroundColor: Colors.deepPurple,
      //   centerTitle: true,
      //   bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(56),
      //     child: Padding(
      //       padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
      //       child: TextFormField(
      //         onChanged: (value) => {
      //           setState(
      //             () {
      //               query = value;
      //               result.clear();
      //               idx = 0;
      //               searchPaginateData();
      //             },
      //           ),
      //         },
      //         decoration: InputDecoration(
      //           hintText: "what are you looking for ?",
      //           prefixIcon: Icon(Icons.search),
      //           border: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(5),
      //             borderSide: BorderSide.none,
      //           ),
      //           suffixIcon:
      //               IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
      //           contentPadding: EdgeInsets.zero,
      //           filled: true,
      //           fillColor: Colors.white,
      //         ),
      //       ),
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: signUserOut,
      //       iconSize: 40,
      //       icon: Icon(Icons.logout),
      //     ),
      //   ],
      // );
    );
  }
}
