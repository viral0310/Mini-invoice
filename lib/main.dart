import 'package:flutter/material.dart';
import 'package:mini_invoice/pages/add_deatils.dart';
import 'package:mini_invoice/pages/invoice_id.dart';
import 'package:mini_invoice/pages/invoice_to.dart';
import 'package:mini_invoice/pages/item.dart';
import 'package:mini_invoice/pages/main_page.dart';
import 'package:mini_invoice/pages/payment.dart';
import 'package:mini_invoice/pages/pdf.dart';
import 'package:mini_invoice/pages/signature.dart';
import 'package:mini_invoice/pages/splashScreen.dart';
import 'package:mini_invoice/pages/your_details.dart';
import 'constatnt/Global.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: AppColors.primaryColor),
        fontFamily: 'Nunito',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const splashScreen(),
        '/main_page': (context) => const MainPage(),
        '/add_details': (context) => const AddDetails(),
        '/invoice_id': (context) => const InvoiceId(),
        '/your_details': (context) => const YourDetails(),
        '/invoice_to': (context) => const InvoiceTo(),
        '/items': (context) => const Items(),
        '/payment': (context) => const Payment(),
        '/signature': (context) => const Signature(),
        '/pdf': (context) => const Pdf(),
      },
    ),
  );
}
