import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:get_it/get_it.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/transactions/transaction-model.dart';

class TransactionBack {
  final _client = GetIt.instance.get<BackClient>();
  DateTime lastModified;

  Future<Result<List<TransactionModel>>> transactions() async {
    final resp = await _client.get(
      "/transactions",
      headers:
          lastModified ?? {'If-Modified-Since': lastModified.toIso8601String()},
    );
    return resp.mapOk(
      (resp) {
        switch (resp.statusCode) {
          case 200:
            if (resp.headers.containsKey("Last-Modified"))
              lastModified = DateTime.parse(resp.headers["Last-Modified"]);
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
