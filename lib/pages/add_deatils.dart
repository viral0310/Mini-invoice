import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constatnt/Global.dart';
import '../constatnt/item_class.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({Key? key}) : super(key: key);

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  List<Map<String, dynamic>> alldata = [
    {
      'icon': Icons.indeterminate_check_box,
      'title': 'Invoice ID',
      'subtitle': 'add Date',
      'routes': '/invoice_id'
    },
    {
      'icon': Icons.inventory_rounded,
      'title': 'Your details',
      'subtitle': 'Business details',
      'routes': '/your_details'
    },
    {
      'icon': Icons.people_alt,
      'title': 'Invoice to',
      'subtitle': 'add payer',
      'routes': '/invoice_to',
    },
    {
      'icon': Icons.shopping_cart_rounded,
      'title': 'Items',
      'subtitle': 'add items',
      'routes': '/items'
    },
    {
      'icon': Icons.payment_outlined,
      'title': 'Payment',
      'subtitle': 'add payment',
      'routes': '/payment',
    },
    {
      'icon': Icons.draw,
      'title': 'Signature',
      'subtitle': 'add image',
      'routes': '/signature'
    },
    {
      'icon': Icons.picture_as_pdf,
      'title': 'Pdf',
      'subtitle': 'Show Pdf',
      'routes': '/pdf'
    },
  ];
  // late Invoice I;
  List<Invoice> allInvoices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //backgroundColor: AppColors.kPrimaryColor,
        title: const Text(
          "New Invoice",
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.clear_sharp,
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 770,
          color: AppColors.primaryColor.withOpacity(0.02),
          padding: const EdgeInsets.all(5),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,

            //shrinkWrap: true,
            children: alldata.map((data) {
              return Container(
                padding: const EdgeInsets.all(4),
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            data['icon'],
                            size: 40,
                            color: AppColors.primaryColor.withOpacity(0.8),
                          ),
                          Text(data['title'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(data['subtitle'],
                              style: const TextStyle(fontSize: 16)),
                          SizedBox(
                            height: 30,
                            child: CupertinoButton(
                                color: AppColors.secondaryColor,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 60),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(data['routes']);
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
