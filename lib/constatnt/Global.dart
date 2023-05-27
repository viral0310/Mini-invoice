import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:pdf/widgets.dart' as pw;
import 'item_class.dart';

//import 'Strings.dart';

class Global {
  //splash screen
  static String app_Name = "Mini Invoice";

  //invoice id
  static String? invoice_Id;
  static String? date;
  //your_details
  static String? business_name;
  static String? email;
  static String? phone;
  static String? address;
  static File? image;
  //invoice_to
  static String? payer_name;
  static String? payer_email;
  static String? payer_phone;
  static String? payer_address;
  //add_new_item dailogbox
  static String? item_name;
  static double? item_cost;
  static int? item_quantity;
  static List<Item> item_details_list = [];
  static double total = 0;
  static List? total_List;
  static List? cgst_List;
  static List? sgst_List;
  static List? final_total_List;
  static double sum = 0;
  static double cgst = 0;
  static double sgst = 0;
  static int rate = 5;
  static List<String> tableList = [
    'Name',
    'Item cost',
    'Quantity',
    'Total',
    'Actions'
  ];
  static List<String> pdftableList = [
    'Name',
    'Item cost',
    'Quantity',
    'Total',
  ];

  //payment instruction
  static String? note;

  //Signature
  // static Uint8List? signature;
  static File? SignatureImage;
  //pdf
 // static List pdf = List.generate(10, (index) => pw.Document());
  static final pdf = pw.Document();
  static List<String> pdfViewList = [];
}

class AppColors {
  static Color primaryColor = Color(0xFFf2535b);
  static Color secondaryColor = Color(0xFFf3f5f5);
}
