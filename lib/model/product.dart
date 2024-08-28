class Product {
  final String state;
  final String district;
  final String market;
  final String commodity;
  final String variety;
  final String grade;
  final String arrivalDate;
  final double minPrice;
  final double maxPrice;
  final double modalPrice;

  Product({
    required this.state,
    required this.district,
    required this.market,
    required this.commodity,
    required this.variety,
    required this.grade,
    required this.arrivalDate,
    required this.minPrice,
    required this.maxPrice,
    required this.modalPrice,
  });

  // Convert JSON to Record object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      state: json['state'],
      district: json['district'],
      market: json['market'],
      commodity: json['commodity'],
      variety: json['variety'],
      grade: json['grade'],
      arrivalDate: json['arrival_date'],
      minPrice: double.parse(json['min_price']),
      maxPrice: double.parse(json['max_price']),
      modalPrice: double.parse(json['modal_price']),
    );
  }
}
