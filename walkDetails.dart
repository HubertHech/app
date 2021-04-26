import 'package:google_maps_flutter/google_maps_flutter.dart';

class WalkDetails
{
  String pickup_address;
  String dropoff_address;
  LatLng pickup;
  LatLng dropoff;
  String walk_reques_id;
  String payment_method;
  String rider_name;
  String rider_phone;

  WalkDetails({this.pickup_address, this.dropoff_address, this.pickup, this.dropoff, this.walk_reques_id, this.payment_method, this.rider_name, this.rider_phone});
}