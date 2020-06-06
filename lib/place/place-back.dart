import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/place/place-store.dart';

class PlaceBack {
  final _client = GetIt.I.get<BackClient>();

  Future<BackResult<List<PlaceModel>>> places() async {
    final resp = await _client.get("/parking-lots");

    return resp.mapOk<List<PlaceModel>>((resp) {
      switch (resp.statusCode) {
        case 200:
          final _body = json.decode(resp.body) as List<dynamic>;
          return BackResult(
            _body.map((e) => PlaceModel.fromJson(e as Map<String, dynamic>)).toList(),
          );
        default:
          return BackResult.error("Server error");
      }
    });
  }
}
