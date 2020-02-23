import 'package:auto_route/auto_route_annotations.dart';
import 'package:parks/activities/detailPage.dart';
import 'package:parks/activities/listPage.dart';
import 'package:parks/auth/page.dart';
import 'package:parks/place/detailPage.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  ActivitiesPage home;
  ActivityPage activityDetail;
  PlacePage placeDetail;
  AuthPage auth;
}
