import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/data_model/wallet_balance_response.dart';
import 'package:active_ecommerce_flutter/data_model/wallet_recharge_response.dart';
import 'package:flutter/foundation.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class WalletRepository {
  Future<WalletBalanceResponse> getBalance() async {
    final response =
        await http.get("${AppConfig.BASE_URL}/wallet/balance/${user_id.value}",headers: { "Authorization": "Bearer ${access_token.value}"},);
    //print(response.body.toString());
    return walletBalanceResponseFromJson(response.body);
  }

  Future<WalletRechargeResponse> getRechargeList({int page = 1 }) async {
    final response =
        await http.get("${AppConfig.BASE_URL}/wallet/history/${user_id.value}?page=${page}",headers: { "Authorization": "Bearer ${access_token.value}"},);
    return walletRechargeResponseFromJson(response.body);
  }
}
