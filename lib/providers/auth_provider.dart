import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mtelapp/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  String? loadedIme;
  String? loadedPrezime;
  String? loadedEmail;
  String? loadedTelefon;
  String? loadedId;

  bool get isAuth {
    if (token != null) {
      return true;
    }

    return false;
  }

  String? get token {
    if (_expiryDate != null && _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }

    return null;
  }

  String? get userId {
    return _userId;
  }

  String? get getIme {
    return loadedIme;
  }

  String? get getPrezime {
    return loadedPrezime;
  }

  String? get getEmail {
    return loadedEmail;
  }

  String? get getTelefon {
    return loadedTelefon != null ? loadedTelefon : 'Prazno';
  }

  Future<void> updateUserData(String email, String ime, String prezime, String telefon) async {
    final url = Uri.parse('https://mtelapp-ac423-default-rtdb.europe-west1.firebasedatabase.app/userData/$loadedId.json/?auth=$token');
    try {
      final response = http.patch(
        url,
        body: (json.encode({
          'email': email,
          'ime': ime,
          'prezime': prezime,
          'telefon': telefon,
        })),
      );
      notifyListeners();
    } catch (e) {
      print('EROR');
      throw e;
    }
  }

  Future<void> readUserData() async {
    final url = Uri.parse('https://mtelapp-ac423-default-rtdb.europe-west1.firebasedatabase.app/userData.json?auth=$token');

    final response = http.get(url).then((response) {
      final data = json.decode(response.body) as Map<String, dynamic>;

      data.forEach((key, value) {
        if (value['userId'].toString() == userId.toString()) {
          loadedId = key;
          loadedIme = value['ime'];
          loadedPrezime = value['prezime'];
          loadedEmail = value['email'];
          loadedTelefon = value['telefon'];

          notifyListeners();
        }
      });
    });
  }

  Future<void> register(String ime, String prezime, String email, String password) async {
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDORvJIxq1C4TfI7aAwJQ12y7d2kY5agls');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      final token = responseData['idToken'];
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      } else {
        try {
          final url2 = Uri.parse('https://mtelapp-ac423-default-rtdb.europe-west1.firebasedatabase.app/userData.json?auth=$token');
          final response2 = await http.post(
            url2,
            body: json.encode(
              {
                'userId': responseData['localId'],
                'ime': ime,
                'prezime': prezime,
                'email': email,
              },
            ),
          );
        } catch (e) {
          throw e;
        }
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDORvJIxq1C4TfI7aAwJQ12y7d2kY5agls');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
