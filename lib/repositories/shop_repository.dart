import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/data_model/shop_response.dart';
import 'package:active_ecommerce_flutter/data_model/shop_details_response.dart';
import 'package:active_ecommerce_flutter/data_model/product_mini_response.dart';
import 'package:flutter/foundation.dart';

class ShopRepository {
  Future<ShopResponse> getShops({name = "", page = 1}) async {
    final response = await http
        .get("${AppConfig.BASE_URL}/shops" + "?page=${page}&name=${name}");
    return shopResponseFromJson(response.body);
  }

  Future<ShopDetailsResponse> getShopInfo({@required id = 0}) async {
    final response = await http.get("${AppConfig.BASE_URL}/shops/details/${id}");
    return shopDetailsResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getTopFromThisSellerProducts({int id = 0}) async {
    final response = await http
        .get("${AppConfig.BASE_URL}/shops/products/top/" + id.toString());
    return productMiniResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getNewFromThisSellerProducts({int id = 0}) async {
    final response = await http
        .get("${AppConfig.BASE_URL}/shops/products/new/" + id.toString());
    return productMiniResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getfeaturedFromThisSellerProducts({int id = 0}) async {
    final response = await http
        .get("${AppConfig.BASE_URL}/shops/products/featured/" + id.toString());
    return productMiniResponseFromJson(response.body);
  }
}
