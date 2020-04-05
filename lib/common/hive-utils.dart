import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parks/common/mock-data.dart';
import 'package:parks/transactions/transaction-model.dart';
import 'package:parks/user-parking/paymentMethod.dart';
import 'package:parks/user-parking/user-model.dart';
import 'package:parks/user-parking/vehicle.dart';

const USER_BOX = "user";
const TRANSACTIONS_BOX = "transactions";
const PLACES_BOX = "places";

Future initHive({bool mock = false}) async {
  await Hive.initFlutter();

  // Transactions
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionStateAdapter());
  Hive.registerAdapter(TransactionPlaceModelAdapter());

  // User
  Hive.registerAdapter(PaymentMethodTypeAdapter());
  Hive.registerAdapter(PaymentMethodAdapter());
  Hive.registerAdapter(VehicleModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

  final userBox = await Hive.openBox<UserModel>(USER_BOX);
  final transactionsBox =
      await Hive.openBox<TransactionModel>(TRANSACTIONS_BOX);

  if (mock) {
    if (userBox.length != 1) {
      await userBox.clear();
      await userBox.add(mockUser);
    }
    if (transactionsBox.length != mockTransactions.length) {
      await transactionsBox.clear();
      await transactionsBox.addAll(mockTransactions);
    }
  }
}

Box<TransactionModel> getTransactionsBox() {
  return Hive.box<TransactionModel>(TRANSACTIONS_BOX);
}

Box<UserModel> getUserBox() {
  return Hive.box<UserModel>(USER_BOX);
}
