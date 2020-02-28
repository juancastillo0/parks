import 'package:auto_route/auto_route_annotations.dart';
import 'package:parks/activity/activity-detail.dart';
import 'package:parks/activity/activity-list.dart';
import 'package:parks/auth/auth-page.dart';
import 'package:parks/place/place-detail.dart';
import 'package:parks/place/place-list.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  ActivitiesPage home;
  ActivityPage activityDetail;
  PlacePage placeDetail;
  AuthPage auth;
  PlacesPage places;
}
