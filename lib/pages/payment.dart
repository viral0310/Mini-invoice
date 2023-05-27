import 'package:flutter/material.dart';

import '../constatnt/Global.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  TextStyle tStyle = const TextStyle(fontSize: 18);
  final GlobalKey<FormState> payment_instruction_formkey =
      GlobalKey<FormState>();
  final TextEditingController note_controller = TextEditingController();
  InputDecoration textFormFieldDeco = InputDecoration(
    filled: true,
    fillColor: Colors.grey.withOpacity(0.1),
    focusColor: AppColors.secondaryColor,
    hintStyle: const TextStyle(
        color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
    hintText: "",
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.0),
      borderRadius: BorderRadius.circular(4.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondaryColor, width: 0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Payment Instruction",
          style: TextStyle(fontWeight: FontWeight.bold),
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
          padding: const EdgeInsets.all(20),
          child: Form(
            key: payment_instruction_formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Note",
                  style: tStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your note first....";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      Global.note = val;
                    });
                  },
                  maxLines: 6,
                  cursorColor: AppColors.primaryColor,
                  controller: note_controller,
                  decoration: textFormFieldDeco,
                ),
                const SizedBox(
                  height: 500 - 14,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const BeveledRectangleBorder(),
                          primary: AppColors.primaryColor,
                          /* padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 40),*/
                        ),
                        onPressed: () {
                          if (payment_instruction_formkey.currentState!
                              .validate()) {
                            payment_instruction_formkey.currentState!.save();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  const Text("All data successfully saved..."),
                              backgroundColor: AppColors.primaryColor,
                              behavior: SnackBarBehavior.floating,
                            ));
                          }
                        },
                        child: const Text(
                          "SAVE",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
