import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app_controller/app_controller.dart';
import '../../core/utils/common/console.dart';
import '../network/internet_connectivity.dart';
import 'model/api_response_model.dart';

class ApiClient {
  var appController = Get.find<AppController>();

  Future<ApiResponseModel> get({required String url}) async {
    Console.debug("======================= GET =====================");
    Console.debug("Api : $url");
    Console.debug("Header : ${appController.getHeader()}");
    Console.debug("==================================================");
    if (await ConnectivityChecker().checkConnectivity()) {
      try {
        http.Response response = await http.get(Uri.parse(url), headers: appController.getHeader());
        Console.debug("======================== Response ==========================");
        Console.debug("response : ${response.body}");
        return ApiResponseModel.fromJson(json.decode(response.body) as Map<String, dynamic>, response.statusCode);
      } on TimeoutException {
        throw Exception('Request timed out');
      } catch (e) {
        throw Exception('Something went wrong please try after some time');
      }
    } else {
      throw Exception('Connection issue, please check your internet connection');
    }
  }

  Future<ApiResponseModel> post({required String url, required Map<String, dynamic>? body}) async {
    Console.debug("======================= POST =====================");
    Console.debug("Api : $url");
    Console.debug("Header : ${appController.getHeader()}");
    Console.debugLog(" ${jsonEncode(body)}");
    Console.debug("==================================================");
    if (await ConnectivityChecker().checkConnectivity()) {
      try {
        http.Response response = await http.post(Uri.parse(url), headers: appController.getHeader(), body: jsonEncode(body));
        Console.debug("======================== Response ==========================");
        Console.debug("response : ${response.body}");
        return ApiResponseModel.fromJson(json.decode(response.body) as Map<String, dynamic>, response.statusCode);
      } on TimeoutException {
        throw Exception('Request timed out');
      } on SocketException {
        throw Exception('Something went wrong please try after some time');
      }
    } else {
      throw Exception('Connection issue, please check your internet connection');
    }
  }

  Future<ApiResponseModel> put({required String url, required Map<String, dynamic>? body}) async {
    Console.debug("======================= PUT =====================");
    Console.debug("Api : $url");
    Console.debug("Header : ${appController.getHeader()}");
    Console.debugLog(" ${jsonEncode(body)}");
    Console.debug("==================================================");
    if (await ConnectivityChecker().checkConnectivity()) {
      try {
        http.Response response = await http.put(Uri.parse(url), headers: appController.getHeader(), body: jsonEncode(body));
        Console.debug("======================== Response ==========================");
        Console.debug("==Response : ${response.body}");
        return ApiResponseModel.fromJson(json.decode(response.body) as Map<String, dynamic>, response.statusCode);
      } on TimeoutException {
        throw Exception('Request timed out');
      } on SocketException {
        throw Exception('Something went wrong please try after some time');
      }
    } else {
      throw Exception('Connection issue, please check your internet connection');
    }
  }

  Future<ApiResponseModel> delete({required String url}) async {
    Console.debug("======================= DELETE =====================");
    Console.debug("Api : $url");
    Console.debug("header : ${appController.getHeader()}");
    Console.debug("==================================================");

    if (await ConnectivityChecker().checkConnectivity()) {
      try {
        http.Response response = await http.delete(Uri.parse(url), headers: appController.getHeader()).timeout(const Duration(seconds: 30));
        Console.debug("======================= RESPONSE =====================");
        Console.debug("response statusCode : ${response.statusCode}");
        Console.debug("response : ${response.body}");
        return ApiResponseModel.fromJson(json.decode(response.body) as Map<String, dynamic>, response.statusCode);
      } on TimeoutException {
        throw Exception('Request timed out');
      } on SocketException {
        throw Exception('Something went wrong please try after some time');
      }
    } else {
      throw Exception('Connection issue, please check your internet connection');
    }
  }
}
