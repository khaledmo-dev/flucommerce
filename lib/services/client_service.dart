// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flucommerce/app/app.logger.dart';
import 'package:flucommerce/consts.dart';
import 'package:http/http.dart' as http;

extension FormattedMessage on Exception {
  String get getMessage {
    return toString().substring(11);
  }
}

class ClientService {
  final _client = http.Client();

  final int TIME_OUT_DURATION = 20;

  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    "Authorization":
        "Basic ${base64Encode(utf8.encode(AppConstants.authorizationToken))}"
  };

  var logger = getLogger('ClientService');

  final _baseUrl = AppConstants.baseUrl;

  //GET
  Future get({String? baseUrl, required String api}) async {
    var uri = Uri.parse(baseUrl ?? _baseUrl + api);
    logger.i(baseUrl ?? _baseUrl + api);
    try {
      var response = await _client
          .get(
            uri,
            headers: headers,
          )
          .timeout(Duration(seconds: TIME_OUT_DURATION));

      if (response.statusCode > 205) {
        logger.e(response.body);
        throw response.body;
      }

      return jsonDecode(response.body);
    } catch (e) {
      logger.e(e);
      throw errorMessage(e);
    }
  }

  //POST
  Future post({String? baseUrl, required String api, Object? body}) async {
    var uri = Uri.parse(baseUrl ?? _baseUrl + api);
    logger.i(uri.path);

    try {
      var payload = json.encode(body);
      var response = await _client
          .post(
            uri,
            body: payload,
            headers: headers,
          )
          .timeout(Duration(seconds: TIME_OUT_DURATION));

      if (response.statusCode > 205) {
        logger.e(response.body);
        throw response.body;
      }

      logger.d(response.body);

      return jsonDecode(response.body);
    } catch (e) {
      logger.e(e);
      throw errorMessage(e);
    }
  }

  Future put({String? baseUrl, required String api, Object? body}) async {
    var uri = Uri.parse(baseUrl ?? _baseUrl + api);
    logger.i(uri.path);

    try {
      var payload = json.encode(body);
      var response = await _client
          .put(
            uri,
            body: payload,
            headers: headers,
          )
          .timeout(Duration(seconds: TIME_OUT_DURATION));

      if (response.statusCode > 205) {
        logger.e(response.body);
        throw response.body;
      }

      logger.d(response.body);

      return jsonDecode(response.body);
    } catch (e) {
      logger.e(e);
      throw errorMessage(e);
    }
  }
}

class AppException implements Exception {
  final String body;

  AppException({required this.body});
}

String errorMessage(dynamic error) {
  var message = error.toString();
  if (message.contains('SocketException')) {
    return 'Check Your Internet Connection';
  }
  return message;
}
