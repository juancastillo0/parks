import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parks/common/mock-data.dart';
import 'package:parks/place/place-store.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/user-parking/paymentMethod.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/vehicle.dart';

const USER_BOX = "user";
const TRANSACTIONS_BOX = "transactions";
const PLACES_BOX = "places";
const SETTINGS_BOX = "settings";

Future initHive({bool mock = false}) async {
  await Hive.initFlutter();

  // Places
  Hive.registerAdapter(PlaceModelAdapter());

  // Transactions
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionStateAdapter());
  Hive.registerAdapter(TransactionPlaceModelAdapter());

  // User
  Hive.registerAdapter(PaymentMethodTypeAdapter());
  Hive.registerAdapter(PaymentMethodAdapter());
  Hive.registerAdapter(VehicleModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

  final userBox = await _openBox<UserModel>(USER_BOX);
  final transactionsBox = await _openBox<TransactionModel>(TRANSACTIONS_BOX);
  final placesBox = await _openBox<PlaceModel>(PLACES_BOX);
  await Hive.openBox(SETTINGS_BOX);

  if (mock) {
    if (userBox.length != 1) {
      await userBox.clear();
      await userBox.add(mockUser);
    }
    if (transactionsBox.length != mockTransactions.length) {
      await transactionsBox.clear();
      await transactionsBox.putAll(
        Map.fromEntries(mockTransactions.map((e) => MapEntry(e.id, e))),
      );
    }
    if (placesBox.length != mockPlaces.length) {
      await placesBox.clear();
      await placesBox.addAll(mockPlaces);
    }
  }
}

Future<Box<T>> _openBox<T>(String name) async {
  Box<T> box;
  try {
    box = await Hive.openBox<T>(name);
  } catch (_) {
    Hive.deleteBoxFromDisk(name);
    box = await Hive.openBox<T>(name);
  }
  return box;
}

Box<TransactionModel> getTransactionsBox() {
  return Hive.box<TransactionModel>(TRANSACTIONS_BOX);
}

Box<UserModel> getUserBox() {
  return Hive.box<UserModel>(USER_BOX);
}

Box<PlaceModel> getPlacesBox() {
  return Hive.box<PlaceModel>(PLACES_BOX);
}

Box getSettingsBox() {
  return Hive.box(SETTINGS_BOX);
}

class SettingsBox {
  static String _tokenKey = "token";

  static Future setToken(String token) async {
    await getSettingsBox().put(_tokenKey, token);
  }

  static String getToken() {
    return getSettingsBox().get(_tokenKey);
  }
}
