// lib/models/address_model.dart
class AddressModel {
  final String name;
  final String mobile;
  final String pinCode;
  final String address;
  final String locality;
  final String city;
  final String state;
  final String type;

  const AddressModel({
    required this.name,
    required this.mobile,
    required this.pinCode,
    required this.address,
    required this.locality,
    required this.city,
    required this.state,
    required this.type,
  });
}