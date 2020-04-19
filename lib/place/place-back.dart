import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/place/place-store.dart';

class PlaceBack {
  final _client = GetIt.I.get<BackClient>();

  Future<Result<List<PlaceModel>>> places() async {
    final resp = await _client.get("/parking-lots");

    return resp.mapOk<List<PlaceModel>>((resp) {
      switch (resp.statusCode) {
        case 200:
          final _body = json.decode(resp.body) as List<dynamic>;
          return Result(
            _body.map((e) => PlaceModel.fromJson(e)).toList(),
          );
        default:
          return Result.err("Server error");
      }
    });
  }
}
