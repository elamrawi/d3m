import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/address_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_add_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_update_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_update_location_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_delete_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_make_default_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_update_in_cart_response.dart';
import 'package:active_ecommerce_flutter/data_model/city_response.dart';
import 'package:active_ecommerce_flutter/data_model/country_response.dart';
import 'package:active_ecommerce_flutter/data_model/shipping_cost_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/foundation.dart';

class AddressRepository {
  Future<AddressResponse> getAddressList() async {
    final response = await http.get(
      "${AppConfig.BASE_URL}/user/shipping/address/${user_id.value}",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.value}"
      },
    );
    print(response.body.toString());
    return addressResponseFromJson(response.body);
  }

  Future<AddressAddResponse> getAddressAddResponse(
      @required String address,
      @required String country,
      @required String city,
      @required String postal_code,
      @required String phone) async {
    var post_body = jsonEncode({
      "user_id": "${user_id.value}",
      "address": "$address",
      "country": "$country",
      "city": "$city",
      "postal_code": "$postal_code",
      "phone": "$phone"
    });
    final response =
        await http.post("${AppConfig.BASE_URL}/user/shipping/create",
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.value}"
            },
            body: post_body);

    return addressAddResponseFromJson(response.body);
  }

  Future<AddressUpdateResponse> getAddressUpdateResponse(
      @required int id,
      @required String address,
      @required String country,
      @required String city,
      @required String postal_code,
      @required String phone) async {
    var post_body = jsonEncode({
      "id": "${id}",
      "user_id": "${user_id.value}",
      "address": "$address",
      "country": "$country",
      "city": "$city",
      "postal_code": "$postal_code",
      "phone": "$phone"
    });
    final response =
    await http.post("${AppConfig.BASE_URL}/user/shipping/update",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.value}"
        },
        body: post_body);

    return addressUpdateResponseFromJson(response.body);
  }

  Future<AddressUpdateLocationResponse> getAddressUpdateLocationResponse(
      @required int id,
      @required double latitude,
      @required double longitude,
      ) async {
    var post_body = jsonEncode({
      "id": "${id}",
      "user_id": "${user_id.value}",
      "latitude": "$latitude",
      "longitude": "$longitude"

    });
    final response =
    await http.post("${AppConfig.BASE_URL}/user/shipping/update-location",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.value}"
        },
        body: post_body);

    return addressUpdateLocationResponseFromJson(response.body);
  }

  Future<AddressMakeDefaultResponse> getAddressMakeDefaultResponse(
    @required int id,
  ) async {
    var post_body = jsonEncode({
      "user_id": "${user_id.value}",
      "id": "$id",
    });
    final response =
        await http.post("${AppConfig.BASE_URL}/user/shipping/make_default",
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.value}"
            },
            body: post_body);

    return addressMakeDefaultResponseFromJson(response.body);
  }

  Future<AddressDeleteResponse> getAddressDeleteResponse(
    @required int id,
  ) async {
    final response = await http.get(
      "${AppConfig.BASE_URL}/user/shipping/delete/$id",
      headers: {"Authorization": "Bearer ${access_token.value}"},
    );

    return addressDeleteResponseFromJson(response.body);
  }

  Future<CityResponse> getCityList() async {
    final response = await http.get("${AppConfig.BASE_URL}/cities");

    return cityResponseFromJson(response.body);
  }

  Future<CountryResponse> getCountryList() async {
    final response = await http.get("${AppConfig.BASE_URL}/countries");
    return countryResponseFromJson(response.body);
  }

  Future<ShippingCostResponse> getShippingCostResponse(@required int owner_id,
      @required int user_id, @required String city_name) async {
    var post_body = jsonEncode({
      "owner_id": "${owner_id}",
      "user_id": "$user_id",
      "city_name": "$city_name"
    });
    final response = await http.post("${AppConfig.BASE_URL}/shipping_cost",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.value}"
        },
        body: post_body);

    //(post_body.toString());

    return shippingCostResponseFromJson(response.body);
  }

  Future<AddressUpdateInCartResponse> getAddressUpdateInCartResponse(
    @required int address_id,
  ) async {
    var post_body = jsonEncode(
        {"address_id": "${address_id}", "user_id": "${user_id.value}"});
    final response =
        await http.post("${AppConfig.BASE_URL}/update-address-in-cart",
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.value}"
            },
            body: post_body);

    return addressUpdateInCartResponseFromJson(response.body);
  }
}
