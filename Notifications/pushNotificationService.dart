import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gohaupetsitter_app/Models/walkDetails.dart';
import 'package:gohaupetsitter_app/Notifications/notificationDialog.dart';
import 'package:gohaupetsitter_app/configMaps.dart';
import 'package:gohaupetsitter_app/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

class PushNotificationService
{
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future initialize(context) async
  {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      retrieveRideRequestInfo(getWalkRequestId(message), context);

      if (message.notification != null) {
        retrieveRideRequestInfo(getWalkRequestId(message), context);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> NotificationDialog()));
    });
    Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
      await Firebase.initializeApp();
      print("Handling a background message: ${message.messageId}");
    }
    void main() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        badge: true,
      );
      runApp(MyApp());
    }
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidNotificationDetails android = AndroidNotificationDetails('id', 'notiTitle', 'notiDesc', importance: Importance.max, priority: Priority.max);
  IOSNotificationDetails ios = IOSNotificationDetails();

  Future<String> getToken() async
  {
    String token = await firebaseMessaging.getToken();
    print("this is token ::");
    print(token);
    petsitterRef.child(currentfirebaseUser.uid).child("token").set(token);

    firebaseMessaging.subscribeToTopic("petsitters");
    firebaseMessaging.subscribeToTopic("users");
  }
  String getWalkRequestId(message)
  {
    String walkRequestID = "";
    if(Platform.isAndroid)
    {
      walkRequestID = message.data['walk_request_id'];
    }
    else
    {
      walkRequestID = message['walk_request_id'];
    }

    return walkRequestID;
  }

  void retrieveRideRequestInfo(String walkRequestID, BuildContext context)
  {
    newRequestRef.child(walkRequestID).once().then((DataSnapshot dataSnapShot)
    {
      if(dataSnapShot.value != null)
      {
        double pickUpLocationLat = double.parse(dataSnapShot.value['pickup']['latitude'].toString());
        double pickUpLocationLng = double.parse(dataSnapShot.value['pickup']['longitude'].toString());
        String pickUpAddress = dataSnapShot.value['pickup_address'].toString();

        double dropOffLocationLat = double.parse(dataSnapShot.value['dropoff']['latitude'].toString());
        double dropOffLocationLng = double.parse(dataSnapShot.value['dropoff']['longitude'].toString());
        String dropOffAddress = dataSnapShot.value['dropoff_address'].toString();

        String paymentMethod = dataSnapShot.value['payment_method'].toString();

        WalkDetails walkDetails = WalkDetails();
        walkDetails.walk_reques_id = walkRequestID;
        walkDetails.pickup_address = pickUpAddress;
        walkDetails.dropoff_address = dropOffAddress;
        walkDetails.pickup = LatLng(pickUpLocationLat, pickUpLocationLng);
        walkDetails.dropoff = LatLng(dropOffLocationLat, dropOffLocationLng);
        walkDetails.payment_method = paymentMethod;

        print("Information :: ");
        print(walkDetails.pickup_address);
        print(walkDetails.dropoff_address);

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => NotificationDialog(walkDetails: walkDetails,),
        );
      }
    });
  }
}