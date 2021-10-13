import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:active_ecommerce_flutter/data_model/payment_type_response.dart';
import 'package:active_ecommerce_flutter/data_model/order_create_response.dart';
import 'package:active_ecommerce_flutter/data_model/paypal_url_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/data_model/razorpay_payment_success_response.dart';
import 'package:active_ecommerce_flutter/data_model/paystack_payment_success_response.dart';
import 'package:active_ecommerce_flutter/data_model/iyzico_payment_success_response.dart';
import 'package:active_ecommerce_flutter/data_model/bkash_begin_response.dart';
import 'package:active_ecommerce_flutter/data_model/bkash_payment_process_response.dart';
import 'package:active_ecommerce_flutter/data_model/nagad_begin_response.dart';
import 'package:active_ecommerce_flutter/data_model/nagad_payment_process_response.dart';

import 'package:active_ecommerce_flutter/data_model/sslcommerz_begin_response.dart';

class PaymentRepository {
  Future<List<PaymentTypeResponse>> getPaymentResponseList({mode = ""}) async {
    final response = await http.get(
      "${AppConfig.BASE_URL}/payment-types?mode=${mode}",
    );

    return paymentTypeResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponse(
      @required int owner_id, @required payment_method) async {
    var post_body = jsonEncode({
      "owner_id": "${owner_id}",
      "user_id": "${user_id.value}",
      "payment_type": "${payment_method}"
    });

    final response = await http.post("${AppConfig.BASE_URL}/order/store",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.value}"
        },
        body: post_body);

    //print(response.body.toString());
    return orderCreateResponseFromJson(response.body);
  }

  Future<PaypalUrlResponse> getPaypalUrlResponse(@required String payment_type,
      @required int order_id, @required double amount) async {
    final response = await http.get(
      "${AppConfig.BASE_URL}/paypal/payment/url?payment_type=${payment_type}&order_id=${order_id}&amount=${amount}&user_id=${user_id.value}",
    );

    print(response.body.toString());
    return paypalUrlResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponseFromWallet(
      @required int owner_id,
      @required payment_method,
      @required double amount) async {
    var post_body = jsonEncode({
      "owner_id": "${owner_id}",
      "user_id": "${user_id.value}",
      "payment_type": "${payment_method}",
      "amount": "${amount}"
    });

    final response =
        await http.post("${AppConfig.BASE_URL}/payments/pay/wallet",
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.value}"
            },
            body: post_body);

    //print(response.body.toString());
    return orderCreateResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponseFromCod(
      @required int owner_id, @required payment_method) async {
    var post_body = jsonEncode({
      "owner_id": "${owner_id}",
      "user_id": "${user_id.value}",
      "payment_type": "${payment_method}"
    });

    final response = await http.post("${AppConfig.BASE_URL}/payments/pay/cod",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.value}"
        },
        body: post_body);

    //print(response.body.toString());
    return orderCreateResponseFromJson(response.body);
  }

  Future<RazorpayPaymentSuccessResponse> getRazorpayPaymentSuccessResponse(
      @required payment_type,
      @required double amount,
      @required int order_id,
      @required String payment_details) async {
    var post_body = jsonEncode({
      "user_id": "${user_id.value}",
      "payment_type": "${payment_type}",
      "order_id": "${order_id}",
      "amount": "${amount}",
      "payment_details": "${payment_details}"
    });

    final response = await http.post("${AppConfig.BASE_URL}/razorpay/success",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.value}"
        },
        body: post_body);

    //print(response.body.toString());
    return razorpayPaymentSuccessResponseFromJson(response.body);
  }

  Future<PaystackPaymentSuccessResponse> getPaystackPaymentSuccessResponse(
      @required payment_type,
      @required double amount,
      @required int order_id,
      @required String payment_details) async {
    var post_body = jsonEncode({
      "user_id": "${user_id.value}",
      "payment_type": "${payment_type}",
      "order_id": "${order_id}",
      "amount": "${amount}",
      "payment_details": "${payment_details}"
    });

    final response = await http.post("${AppConfig.BASE_URL}/paystack/success",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.value}"
        },
        body: post_body);

    //print(response.body.toString());
    return paystackPaymentSuccessResponseFromJson(response.body);
  }

  Future<IyzicoPaymentSuccessResponse> getIyzicoPaymentSuccessResponse(
      @required payment_type,
      @required double amount,
      @required int order_id,
      @required String payment_details) async {
    var post_body = jsonEncode({
      "user_id": "${user_id.value}",
      "payment_type": "${payment_type}",
      "order_id": "${order_id}",
      "amount": "${amount}",
      "payment_details": "${payment_details}"
    });

    final response = await http.post("${AppConfig.BASE_URL}/paystack/success",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.value}"
        },
        body: post_body);

    //print(response.body.toString());
    return iyzicoPaymentSuccessResponseFromJson(response.body);
  }

  Future<BkashBeginResponse> getBkashBeginResponse(
      @required String payment_type,
      @required int order_id,
      @required double amount) async {
    final response = await http.get(
      "${AppConfig.BASE_URL}/bkash/begin?payment_type=${payment_type}&order_id=${order_id}&amount=${amount}&user_id=${user_id.value}",
      headers: {"Authorization": "Bearer ${access_token.value}"},
    );

    print(response.body.toString());
    return bkashBeginResponseFromJson(response.body);
  }

  Future<BkashPaymentProcessResponse> getBkashPaymentProcessResponse(
      @required payment_type,
      @required double amount,
      @required int order_id,
      @required String payment_details) async {
    var post_body = jsonEncode({
      "user_id": "${user_id.value}",
      "payment_type": "${payment_type}",
      "order_id": "${order_id}",
      "amount": "${amount}",
      "payment_details": "${payment_details}"
    });

    final response = await http.post("${AppConfig.BASE_URL}/bkash/process",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.value}"
        },
        body: post_body);

    //print(response.body.toString());
    return bkashPaymentProcessResponseFromJson(response.body);
  }

  Future<SslcommerzBeginResponse> getSslcommerzBeginResponse(
      @required String payment_type,
      @required int order_id,
      @required double amount) async {
    final response = await http.get(
      "${AppConfig.BASE_URL}/sslcommerz/begin?payment_type=${payment_type}&order_id=${order_id}&amount=${amount}&user_id=${user_id.value}",
      headers: {"Authorization": "Bearer ${access_token.value}"},
    );

    print(response.body.toString());
    return sslcommerzBeginResponseFromJson(response.body);
  }


  Future<NagadBeginResponse> getNagadBeginResponse(
      @required String payment_type,
      @required int order_id,
      @required double amount) async {
    final response = await http.get(
      "${AppConfig.BASE_URL}/nagad/begin?payment_type=${payment_type}&order_id=${order_id}&amount=${amount}&user_id=${user_id.value}",
      headers: {"Authorization": "Bearer ${access_token.value}"},
    );

    print(response.body.toString());
    return nagadBeginResponseFromJson(response.body);
  }

  Future<NagadPaymentProcessResponse> getNagadPaymentProcessResponse(
      @required payment_type,
      @required double amount,
      @required int order_id,
      @required String payment_details) async {
    var post_body = jsonEncode({
      "user_id": "${user_id.value}",
      "payment_type": "${payment_type}",
      "order_id": "${order_id}",
      "amount": "${amount}",
      "payment_details": "${payment_details}"
    });

    final response = await http.post("${AppConfig.BASE_URL}/nagad/process",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.value}"
        },
        body: post_body);

    //print(response.body.toString());
    return nagadPaymentProcessResponseFromJson(response.body);
  }
}
