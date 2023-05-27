import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import '../constatnt/Global.dart';
//import '../constatnt/Global.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "My Invoices",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        //backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/add_details');
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        child: (Global.pdfViewList.isEmpty)
            ? Center(
                child: Text(
                  "YOU DONT HAVE ANY INVOICES!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            : Column(
                children: Global.pdfViewList
                    .map(
                      (e) => Card(
                        margin: EdgeInsets.all(5),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () async {
                              final url = e;
                              await OpenFile.open(url);
                            },
                            child: Text(
                              "${e}",
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}
