import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/data_model/brand_response.dart';

class BrandRepository {

  Future<BrandResponse> getFilterPageBrands() async {
    final response =
    await http.get("${AppConfig.BASE_URL}/filter/brands");
    return brandResponseFromJson(response.body);
  }

  Future<BrandResponse> getBrands({name = "", page = 1}) async {
    final response =
    await http.get("${AppConfig.BASE_URL}/brands"+
        "?page=${page}&name=${name}");
    return brandResponseFromJson(response.body);
  }



}
