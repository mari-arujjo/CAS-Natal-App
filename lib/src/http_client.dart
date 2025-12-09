import 'package:http/http.dart' as http;

abstract class IHttpClient{
  get({required String url, Map<String, String>? headers});
  
  post({required String url, Map<String, String>? headers, Object? body});

  update({required String url, Map<String, String>? headers, Object? body});

  patch({required String url, Map<String, String>? headers, Object? body});

  delete({required String url});
}

class HttpClient implements IHttpClient{
  final client = http.Client();

  @override
  delete({required String url}) async {
    return await client.delete(Uri.parse(url));
  }

  @override
  get({required String url, Map<String, String>? headers}) async {
    return await client.get(Uri.parse(url), headers: headers);
  }

  @override
  post({required String url, Map<String, String>? headers, Object? body}) async {
    return await client.post(
      Uri.parse(url),
      headers: headers,
      body: body
    );
  }

  @override
  update({required String url, Map<String, String>? headers, Object? body}) async {
    return await client.put(
      Uri.parse(url),
      headers: headers,
      body: body
    );
  }

  @override
  patch({required String url, Map<String, String>? headers, Object? body}) async {
    return await client.patch(
      Uri.parse(url),
      headers: headers,
      body: body
    );
  }
  
}