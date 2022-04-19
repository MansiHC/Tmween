class CartQuantityModel {
  late int productId;
  late int quantity;

  int get getProductId {
    return productId;
  }

  set setProductId(int id) {
    productId = id;
  }

  int get getQuantity {
    return quantity;
  }

  set setQuantity(int qty) {
    quantity = qty;
  }
}
