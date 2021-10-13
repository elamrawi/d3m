// To parse this JSON data, do
//
//     final addressResponse = addressResponseFromJson(jsonString);

import 'dart:convert';

AddressResponse addressResponseFromJson(String str) => AddressResponse.fromJson(json.decode(str));

String addressResponseToJson(AddressResponse data) => json.encode(data.toJson());

class AddressResponse {
  AddressResponse({
    this.addresses,
    this.success,
    this.status,
  });

  List<Address> addresses;
  bool success;
  int status;

  factory AddressResponse.fromJson(Map<String, dynamic> json) => AddressResponse(
    addresses: List<Address>.from(json["data"].map((x) => Address.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(addresses.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class Address {
  Address({
    this.id,
    this.user_id,
    this.address,
    this.country,
    this.city,
    this.postal_code,
    this.phone,
    this.set_default,
    this.location_available,
    this.lat,
    this.lang
  });

  int id;
  int user_id;
  String address;
  String country;
  String city;
  String postal_code;
  String phone;
  int set_default;
  bool location_available;
  double lat;
  double lang;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    user_id: json["user_id"],
    address: json["address"],
    country: json["country"],
    city: json["city"],
    postal_code: json["postal_code"] == null ? "" :  json["postal_code"],
    phone: json["phone"]== null ? "" :  json["phone"],
    set_default: json["set_default"],
    location_available: json["location_available"],
    lat: json["lat"],
    lang: json["lang"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": user_id,
    "address": address,
    "country": country,
    "city": city,
    "postal_code": postal_code,
    "phone": phone,
    "set_default": set_default,
    "location_available": location_available,
    "lat": lat,
    "lang": lang,
  };
}
