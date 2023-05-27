class Item {
  final String item_Name;
  final double item_Cost;
  final int item_Quantity;
  late double? item_total;
  Item({
    required this.item_Name,
    required this.item_Cost,
    required this.item_Quantity,
    this.item_total,
  });
}

class Invoice {
  final String icon;
  final String title;
  final String subtitle;

  Invoice({required this.icon, required this.title, required this.subtitle});
}
