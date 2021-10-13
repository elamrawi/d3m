import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/coupon_apply_response.dart';
import 'package:active_ecommerce_flutter/data_model/coupon_remove_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';


class CouponRepository{


  Future<CouponApplyResponse> getCouponApplyResponse(
      @required int owner_id, @required String coupon_code ) async {

    var post_body = jsonEncode({"user_id": "${user_id.value}", "owner_id": "$owner_id","coupon_code": "$coupon_code"});
    final response = await http.post("${AppConfig.BASE_URL}/coupon-apply",
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${access_token.value}"},body: post_body );

    return couponApplyResponseFromJson(response.body);
  }

  Future<CouponRemoveResponse> getCouponRemoveResponse(
      @required int owner_id ) async {

    var post_body = jsonEncode({"user_id": "${user_id.value}", "owner_id": "$owner_id"});
    final response = await http.post("${AppConfig.BASE_URL}/coupon-remove",
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${access_token.value}"},body: post_body );

    return couponRemoveResponseFromJson(response.body);
  }


}

