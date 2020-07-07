
import 'package:dio/dio.dart';
import 'api_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'http://10.0.2.2:8000/api';
  var token;

  Response response;
  Dio dio = new Dio(
    BaseOptions(
      baseUrl: ApiConst.URL_SERVER,
    )
  )..interceptors.add(
    LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    )
  );

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    FormData formData = new FormData.fromMap(data);
    response = await dio.post(
      fullUrl,
      data: formData,

    );
    return response;
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await dio.get(
      fullUrl, 
      options: new Options(
        headers: _setHeaders(),
      )
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
