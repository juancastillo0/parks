import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/transactions/transaction-model.dart';

class TransactionBack {
  final _client = GetIt.instance.get<BackClient>();
  DateTime lastModified;

  Future<BackResult<List<TransactionModel>>> transactions() async {
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
            if (resp.headers.containsKey("modified-at")) {
              lastModified = DateTime.parse(resp.headers["modified-at"]);
            }
            final _body = json.decode(resp.body) as List<dynamic>;
            return BackResult(
              _body
                  .map(
                    (e) => TransactionModel.fromJson(e as Map<String, dynamic>),
                  )
                  .toList(),
            );
          case 401:
            _client.setToken(null);
            return BackResult.error("Unauthorized");
          default:
            return BackResult.error("Server Error");
        }
      },
    );
  }

  Future<BackResult<bool>> updateTransactionState(
      String id, bool accept) async {
    final resp = await _client.put("/transactions/$id",
        body: {"state": accept ? "ACTIVE" : "REJECTED"});

    return resp.mapOk<bool>(
      (resp) {
        switch (resp.statusCode) {
          case 200:
            return BackResult(accept);
          case 401:
            _client.setToken(null);
            return BackResult.error("Unauthorized");
          default:
            return BackResult.error("Server Error");
        }
      },
    );
  }
}
