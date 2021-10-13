import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/profile_image_update_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/profile_counters_response.dart';
import 'package:active_ecommerce_flutter/data_model/profile_update_response.dart';
import 'package:active_ecommerce_flutter/data_model/device_token_update_response.dart';

import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/foundation.dart';

class ProfileRepository {

  Future<ProfileCountersResponse> getProfileCountersResponse() async {
    final response = await http.get(
      "${AppConfig.BASE_URL}/profile/counters/${user_id.value}",
      headers: {
        "Authorization": "Bearer ${access_token.value}"
      },
    );
    return profileCountersResponseFromJson(response.body);
  }

  Future<ProfileUpdateResponse> getProfileUpdateResponse(
      @required String name,@required String password) async {

    var post_body = jsonEncode({"id":"${user_id.value}","name": "${name}", "password": "$password"});

    final response = await http.post("${AppConfig.BASE_URL}/profile/update",
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${access_token.value}"},body: post_body );

    //print(response.body.toString());
    return profileUpdateResponseFromJson(response.body);
  }

  Future<DeviceTokenUpdateResponse> getDeviceTokenUpdateResponse(
      @required String device_token) async {

    var post_body = jsonEncode({"id":"${user_id.value}","device_token": "${device_token}"});

    final response = await http.post("${AppConfig.BASE_URL}/profile/update-device-token",
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${access_token.value}"},body: post_body );

    print(response.body.toString());
    return deviceTokenUpdateResponseFromJson(response.body);
  }

  Future<ProfileImageUpdateResponse> getProfileImageUpdateResponse(
      @required String image,@required String filename) async {

    var post_body = jsonEncode({"id":"${user_id.value}","image": "${image}", "filename": "$filename"});
    //print(post_body.toString());

    final response = await http.post("${AppConfig.BASE_URL}/profile/update-image",
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${access_token.value}"},body: post_body );

    //print(response.body.toString());
    return profileImageUpdateResponseFromJson(response.body);
  }

}
