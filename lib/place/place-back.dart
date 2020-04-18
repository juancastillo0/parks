import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:parks/common/back-client.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/place/place-store.dart';

class PlaceBack {
  final _client = BackClient();

  Future<Result<List<PlaceModel>>> places() async {
    final resp = await _client.get("/parking-lots");
    return resp.mapOk((resp) {
      switch (resp.statusCode) {
        case 200:
          return Result(JsonMapper.deserialize<List<PlaceModel>>(resp.body));
        default:
          return Result.err("Server error");
      }
    });
  }
}
