import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  // final String _url = 'http://afyadynamics3.local/api';
  //final String _url ="http://afyadynamics.local/api";
  final String _url = 'https://app.afyadynamics.com/api';
  // final String _url = 'http://10.0.2.2:8000/api';
  // final String _url = 'https://dev.afyadynamics.com/api';


  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;


  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (localStorage.getString('token') != null) {
      token = localStorage.getString('token') ?? '';
    } else {}
  }

  Future<http.Response> multipartFormRequest({
    required String apiUrl,
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
  }) async {
    await _getToken();
    final fullUrl = _url + apiUrl;
    final request = http.MultipartRequest('POST', Uri.parse(fullUrl));

    // Add fields
    request.fields.addAll(fields);

    // Add files
    request.files.addAll(files);

    // Add headers
    request.headers.addAll({
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    });

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }
  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.post(Uri.parse(fullUrl),
        headers: _setHeaders(), body: jsonEncode(data));
  }

  deleteData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.delete(Uri.parse(fullUrl), headers: _setHeaders());
  }

  multipart(data, apiUrl, filePath) async {
    await _getToken();
    var fullUrl = _url + apiUrl;
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl));
    request.files.add(await http.MultipartFile.fromPath("image", filePath));
    data.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    request.headers.clear();
    request.headers.addAll({
      "content-type": "application/json; charset=utf-8;",
      "authorization": "Bearer $token"
    });
    var response = await request.send();
    return await http.Response.fromStream(response);
  }

  saveToCache(key, data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(key, json.encode(data));
  }

  Future<dynamic> getFromCache(String key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getString(key);
    if (data == null || data.isEmpty) return null;

    try {
      return json.decode(data);
    } catch (e) {
      return null;
    }
  }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'authorization': 'Bearer $token'
  };
}
