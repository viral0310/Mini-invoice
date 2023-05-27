import 'package:flutter/material.dart';

import '../constatnt/Global.dart';

class InvoiceId extends StatefulWidget {
  const InvoiceId({Key? key}) : super(key: key);

  @override
  State<InvoiceId> createState() => _InvoiceIdState();
}

class _InvoiceIdState extends State<InvoiceId> {
  TextStyle tStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final GlobalKey<FormState> invoice_id_formkey = GlobalKey<FormState>();
  final TextEditingController date_controller = TextEditingController();
  final TextEditingController invoice_id_controller = TextEditingController();
  InputDecoration textFormFieldDeco(String data) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1),
      focusColor: AppColors.secondaryColor,
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 18,
        //fontWeight: FontWeight.bold,
      ),
      hintText: "${data}",
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondaryColor, width: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        // backgroundColor: AppColors.kPrimaryColor,
        title: const Text(
          "Invoce ID",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 770,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: invoice_id_formkey,
            child: Column(
              children: [
                Expanded(
                  flex: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invoice ID",
                        style: tStyle,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter your Invoice Id first....";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          setState(
                            () {
                              Global.invoice_Id = val;
                            },
                          );
                        },
                        cursorColor: AppColors.primaryColor,
                        controller: invoice_id_controller,
                        decoration: textFormFieldDeco("#12345678"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Date",
                        style: tStyle,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter your Date first....";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          setState(
                            () {
                              Global.date = val;
                            },
                          );
                        },
                        keyboardType: TextInputType.datetime,
                        controller: date_controller,
                        cursorColor: AppColors.primaryColor,
                        decoration: textFormFieldDeco("DD/MM/YYYY"),
                      ),
                      const SizedBox(
                        height: 480,
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const BeveledRectangleBorder(),
                                    primary: AppColors.primaryColor,
                                    padding: const EdgeInsets.all(10.0)),
                                onPressed: () {
                                  if (invoice_id_formkey.currentState!
                                      .validate()) {
                                    invoice_id_formkey.currentState!.save();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: const Text(
                                          "All data successfully saved..."),
                                      backgroundColor: AppColors.primaryColor,
                                      behavior: SnackBarBehavior.floating,
                                    ));
                                  }
                                },
                                child: const Text(
                                  "SAVE",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
