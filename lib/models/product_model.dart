class ProductModel {
  final String productId;
  final String productName;
  final String productDescription;
  final double productPrice;
  final String productImage;
  final String productCategory;
  final int productQuantity;
  ProductModel({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
    required this.productCategory,
    required this.productQuantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      productDescription: json['productDescription'] ?? '',
      productPrice: (json['productPrice'] ?? 0).toDouble(),
      productImage: json['productImage'] ?? '',
      productCategory: json['productCategory'] ?? '',
      productQuantity: json['productQuantity'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productDescription': productDescription,
      'productPrice': productPrice,
      'productImage': productImage,
      'productCategory': productCategory,
      'productQuantity': productQuantity,
    };
  }
}
