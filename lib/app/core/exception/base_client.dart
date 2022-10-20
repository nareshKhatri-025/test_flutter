import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tekzee_test/app/core/endpoint.dart';
import 'package:tekzee_test/app/core/exception/exception_handling.dart';

class BaseClient {
  Future<dynamic> get(String endpoint, [Map<String, String>? header]) async {
    try {
      if (header != null) {
        print(Endpoint.baseUrl + endpoint);
        var response = await http
            .get(Uri.parse(Endpoint.baseUrl + endpoint), headers: header)
            .timeout(Duration(seconds: Endpoint.timeout));
        print(response.statusCode);
        return _getResponse(response);
      } else {
        var response = await http
            .get(Uri.parse(Endpoint.baseUrl + endpoint))
            .timeout(Duration(seconds: Endpoint.timeout));
        return _getResponse(response);
      }
    } on SocketException {
      throw FetchDataException("No Internet Connection", endpoint);
    } on TimeoutException {
      throw ApiNotRespondingException("Take to longer to response", endpoint);
    }
  }

  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> body, [
    Map<String, String>? header,
  ]) async {
    try {
      if (header != null) {
 
        header.addAll({"Content-Type": "application/json"});
        var response = await http
            .post(
              Uri.parse(Endpoint.baseUrl + endpoint),
              body: jsonEncode(body),
              headers: header,
            )
            .timeout(Duration(seconds: Endpoint.timeout));
     

        return _getResponse(response);
      } else {

        var response = await http.post(
          Uri.parse(Endpoint.baseUrl + endpoint),
          body: json.encode(body),
          headers: {"Content-Type": "application/json"},
        ).timeout(Duration(seconds: Endpoint.timeout));


        return _getResponse(response);
      }
    } on SocketException {
      throw FetchDataException("No Internet Connection", endpoint);
    } on TimeoutException {
      throw ApiNotRespondingException("Take to longer to response", endpoint);
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic _getResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        //var responseJson = utf8.decode(response.bodyBytes);
        return json.decode(response.body);

      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());

      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 404:
        throw PageNotFound("Not Found", response.request!.url.toString());
      case 500:
      case 502:
      default:
        throw FetchDataException("Error occured ${response.statusCode}",
            response.request!.url.toString());
    }
  }
}
