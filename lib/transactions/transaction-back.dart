import 'dart:convert';

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
      headers: lastModified != null
          ? {'if-modified-since': lastModified.toIso8601String()}
          : null,
    );

    return resp.mapOk<List<TransactionModel>>(
      (resp) {
        switch (resp.statusCode) {
          case 200:
            if (resp.headers.containsKey("modified-at"))
              lastModified = DateTime.parse(resp.headers["modified-at"]);
            final _body = json.decode(resp.body) as List<dynamic>;
            return Result(
              _body.map((e) => TransactionModel.fromJson(e)).toList(),
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
