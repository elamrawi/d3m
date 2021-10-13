import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:active_ecommerce_flutter/data_model/cart_response.dart';
import 'package:active_ecommerce_flutter/data_model/cart_delete_response.dart';
import 'package:active_ecommerce_flutter/data_model/cart_process_response.dart';
import 'package:active_ecommerce_flutter/data_model/cart_add_response.dart';
import 'package:active_ecommerce_flutter/data_model/cart_summary_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';


class CartRepository{

  Future<List<CartResponse>> getCartResponseList(
      @required int user_id, ) async {

    final response = await http.post("${AppConfig.BASE_URL}/carts/$user_id",
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${access_token.value}"}, );

    return cartResponseFromJson(response.body);
  }

  Future<CartDeleteResponse> getCartDeleteResponse(
      @required int cart_id, ) async {

    final response = await http.delete("${AppConfig.BASE_URL}/carts/$cart_id",
      headers: {"Content-Type": "application/json", "Authorization": "Bearer ${access_token.value}"}, );

    return cartDeleteResponseFromJson(response.body);
  }

  Future<CartProcessResponse> getCartProcessResponse(
      @required String cart_ids, @required String cart_quantities ) async {

    var post_body = jsonEncode({"cart_ids": "${cart_ids}", "cart_quantities": "$cart_quantities"});
    final response = await http.post("${AppConfig.BASE_URL}/carts/process",
      headers: {"Content-Type": "application/json", "Authorization": "Bearer ${access_token.value}"},body: post_body );

    return cartProcessResponseFromJson(response.body);
  }

  Future<CartAddResponse> getCartAddResponse(
      @required int id, @required String variant,@required int user_id,@required int quantity ) async {

    var post_body = jsonEncode({"id": "${id}", "variant": "$variant","user_id": "$user_id","quantity": "$quantity","cost_matrix": AppConfig.purchase_code});

    print(post_body.toString());

    final response = await http.post("${AppConfig.BASE_URL}/carts/add",
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${access_token.value}"},body: post_body );

  print(response.body.toString());
    return cartAddResponseFromJson(response.body);
  }

  Future<CartSummaryResponse> getCartSummaryResponse(@required owner_id) async {
    final response = await http.get("${AppConfig.BASE_URL}/cart-summary/${user_id.value}/${owner_id}",
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${access_token.value}"}, );

    return cartSummaryResponseFromJson(response.body);
  }

}

