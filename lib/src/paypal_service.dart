import 'dart:convert';

import 'package:dio/dio.dart';

import 'dart:async';
import 'dart:convert' as convert;

class PaypalServices {
  final String _clientId, _secretKey;
  final bool _sandboxMode;
  PaypalServices({
    required String clientId,
    required String secretKey,
    required bool sandboxMode,
  }) : _sandboxMode = sandboxMode,
       _secretKey = secretKey,
       _clientId = clientId;

  getAccessToken() async {
    String baseUrl =
        _sandboxMode
            ? "https://api-m.sandbox.paypal.com"
            : "https://api.paypal.com";

    try {
      var authToken = base64.encode(utf8.encode("$_clientId:$_secretKey"));
      final response = await Dio().post(
        '$baseUrl/v1/oauth2/token?grant_type=client_credentials',
        options: Options(
          headers: {
            'Authorization': 'Basic $authToken',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      final body = response.data;
      return {
        'error': false,
        'message': "Success",
        'token': body["access_token"],
      };
    } on DioException {
      return {
        'error': true,
        'message': "Your PayPal credentials seems incorrect",
      };
    } catch (e) {
      return {
        'error': true,
        'message': "Unable to proceed, check your internet connection.",
        'error_explanation': e.toString(),
      };
    }
  }

  Future<Map> createPaypalPayment(
    Map<String, dynamic> transactions,
    accessToken,
  ) async {
    String domain =
        _sandboxMode
            ? "https://api.sandbox.paypal.com"
            : "https://api.paypal.com";

    try {
      final response = await Dio().post(
        '$domain/v1/payments/payment',
        data: jsonEncode(transactions),
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      final body = response.data;
      if (body["links"] != null && body["links"].length > 0) {
        List links = body["links"];

        String executeUrl = "";
        String approvalUrl = "";
        final item = links.firstWhere(
          (o) => o["rel"] == "approval_url",
          orElse: () => null,
        );
        if (item != null) {
          approvalUrl = item["href"];
        }
        final item1 = links.firstWhere(
          (o) => o["rel"] == "execute",
          orElse: () => null,
        );
        if (item1 != null) {
          executeUrl = item1["href"];
        }
        return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
      }
      return {};
    } on DioException catch (e) {
      return {
        'error': true,
        'message': "Payment Failed.",
        'data': e.response?.data,
      };
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> executePayment(url, payerId, accessToken) async {
    try {
      final response = await Dio().post(
        url,
        data: convert.jsonEncode({"payer_id": payerId}),
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      final body = response.data;
      return {'error': false, 'message': "Success", 'data': body};
    } on DioException catch (e) {
      return {
        'error': true,
        'message': "Payment Failed.",
        'data': e.response?.data,
      };
    } catch (e) {
      return {'error': true, 'message': e, 'exception': true, 'data': null};
    }
  }
}
