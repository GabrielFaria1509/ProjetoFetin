import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class HttpService {
  static String get _baseUrl => const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:3000');
  static const Duration _timeout = Duration(seconds: 30);
  
  // Headers seguros padrão
  static Map<String, String> get _defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'User-Agent': 'TISM-App/1.0',
  };
  
  // GET seguro
  static Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await http.get(
        uri,
        headers: {..._defaultHeaders, ...?headers},
      ).timeout(_timeout);
      
      _logRequest('GET', endpoint, response.statusCode);
      return response;
    } catch (e) {
      _logError('GET', endpoint, e);
      rethrow;
    }
  }
  
  // POST seguro
  static Future<http.Response> post(String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await http.post(
        uri,
        headers: {..._defaultHeaders, ...?headers},
        body: body != null ? json.encode(body) : null,
      ).timeout(_timeout);
      
      _logRequest('POST', endpoint, response.statusCode);
      return response;
    } catch (e) {
      _logError('POST', endpoint, e);
      rethrow;
    }
  }
  
  // PUT seguro
  static Future<http.Response> put(String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await http.put(
        uri,
        headers: {..._defaultHeaders, ...?headers},
        body: body != null ? json.encode(body) : null,
      ).timeout(_timeout);
      
      _logRequest('PUT', endpoint, response.statusCode);
      return response;
    } catch (e) {
      _logError('PUT', endpoint, e);
      rethrow;
    }
  }
  
  // DELETE seguro
  static Future<http.Response> delete(String endpoint, {Map<String, String>? headers}) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await http.delete(
        uri,
        headers: {..._defaultHeaders, ...?headers},
      ).timeout(_timeout);
      
      _logRequest('DELETE', endpoint, response.statusCode);
      return response;
    } catch (e) {
      _logError('DELETE', endpoint, e);
      rethrow;
    }
  }
  
  // Validar resposta JSON
  static Map<String, dynamic>? parseJsonResponse(http.Response response) {
    try {
      if (response.body.isEmpty) return null;
      return json.decode(response.body) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
  
  // Log de requisições (apenas em debug)
  static void _logRequest(String method, String endpoint, int statusCode) {
    // Logs removidos para produção
  }
  
  // Log de erros
  static void _logError(String method, String endpoint, dynamic error) {
    // Em produção, enviar para serviço de monitoramento como Sentry
  }
}