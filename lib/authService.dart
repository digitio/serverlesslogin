import 'dart:convert';

import 'package:serverlesslogin/hashPassword.dart';
import 'package:serverlesslogin/secureLogin.dart';
import 'package:serverlesslogin/subscription.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final SecureStorage _secureStorage = SecureStorage();
  final SharedPreferences _prefs;

  AuthService(this._prefs);

  Future<void> register(String username, String password) async {
    String hashedPassword = hashPassword(password);
    await _secureStorage.writeSecureData(username, hashedPassword);
  }

  Future<bool> login(String username, String password) async {
    String? storedHashedPassword =
        await _secureStorage.readSecureData(username);
    if (storedHashedPassword == null) return false;

    String enteredHashedPassword = hashPassword(password);
    return storedHashedPassword == enteredHashedPassword;
  }

  Future<void> saveSubscription(Subscription subscription) async {
    final List<String>? subscriptionsJson =
        _prefs.getStringList('subscriptions') ?? [];
    subscriptionsJson?.add(jsonEncode(subscription.toJson()));
    await _prefs.setStringList('subscriptions', subscriptionsJson!);
  }

  Future<void> updateSubscription(Subscription subscription, int index) async {
    final List<String>? subscriptionsJson =
        _prefs.getStringList('subscriptions') ?? [];
    subscriptionsJson![index] = jsonEncode(subscription.toJson());
    await _prefs.setStringList('subscriptions', subscriptionsJson);
  }

  Future<void> deleteSubscription(int index) async {
    final List<String>? subscriptionsJson =
        _prefs.getStringList('subscriptions') ?? [];
    subscriptionsJson?.removeAt(index);
    await _prefs.setStringList('subscriptions', subscriptionsJson!);
  }

  List<Subscription> getSubscriptions() {
    final List<String>? subscriptionsJson =
        _prefs.getStringList('subscriptions');
    if (subscriptionsJson == null) return [];

    return subscriptionsJson
        .map((json) => Subscription.fromJson(jsonDecode(json)))
        .toList();
  }
}
