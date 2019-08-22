import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  final apiKey = 'AIzaSyAzQi4EXcqp0GuKfXL7g1a48LygDb0xPfU';

  bool isAuth() {
    return token != null;
  }

  String get token {
    if (_expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token != null) {
      return _token;
    } else {
      return null;
    }
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$apiKey';
    Dio dio = Dio();
    try {
      final response = await dio.post(url, queryParameters: {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      });
      _token = response.data['idToken'];
      _userId = response.data['localId'];
      _expiryDate = DateTime.now().add(Duration(seconds: int.parse(response.data['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signin(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
