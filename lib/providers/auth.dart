
import 'package:flutter/widgets.dart';

class Auth with ChangeNotifier {
  String _token;
  String _expiryDate;
  String _userId;

  Future<void> signup() {
    const apiKey = 'AIzaSyAzQi4EXcqp0GuKfXL7g1a48LygDb0xPfU';
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=$apiKey';

    
  }
}