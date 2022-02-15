class AddressModel {
  const AddressModel(
      {required this.name,
      required this.addressLine1,
      required this.addressLine2,
      required this.city,
      required this.state,
      required this.country,
      required this.pincode,
      this.isDefault = false});

  final String name;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String country;
  final String pincode;
  final bool isDefault;

  static fromJson(responseJson) {
    return null;
  }
}
