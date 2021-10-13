// To parse this JSON data, do
//
//     final orderCreateResponse = orderCreateResponseFromJson(jsonString);

import 'dart:convert';

OrderCreateResponse orderCreateResponseFromJson(String str) => OrderCreateResponse.fromJson(json.decode(str));

String orderCreateResponseToJson(OrderCreateResponse data) => json.encode(data.toJson());

class OrderCreateResponse {
  OrderCreateResponse({
    this.order_id,
    this.result,
    this.message,
  });

  int order_id;
  bool result;
  String message;

  factory OrderCreateResponse.fromJson(Map<String, dynamic> json) => OrderCreateResponse(
    order_id: json["order_id"],
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": order_id,
    "result": result,
    "message": message,
  };
}