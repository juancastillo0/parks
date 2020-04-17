import 'package:parks/common/back-client.dart';
import 'package:parks/common/utils.dart';
import 'package:parks/place/place-store.dart';

class PlaceBack{
  final _client = BackClient();

  Future<Result<List<PlaceModel>>> places() async{
    final resp = await _client.get("/parking-lots");

  }
}