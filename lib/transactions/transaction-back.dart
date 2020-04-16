import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:get_it/get_it.dart';
import 'package:parks/auth/auth-back.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/transactions/transaction-model.dart';

class TransactionBack {
  final _client = GetIt.instance.get<BackClient>();

  Future<Result<List<TransactionModel>>> userInfo() async {
    final resp = await _client.get("/transactions");
    return resp.mapOk(
      (resp) {
        switch (resp.statusCode) {
          case 200:
            return Result(
              JsonMapper.deserialize<List<TransactionModel>>(resp.body),
            );
          case 401:
            _client.setToken(null);
            return Result.err("Unauthorized");
          default:
            return Result.err("Server Error");
        }
      },
    );
  }
}
