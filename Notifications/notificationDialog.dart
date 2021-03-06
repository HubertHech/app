import 'package:flutter/material.dart';
import 'package:gohaupetsitter_app/Models/walkDetails.dart';

class NotificationDialog extends StatelessWidget
{
  final WalkDetails walkDetails;
  NotificationDialog({this.walkDetails});
  @override
  Widget build(BuildContext context)

  {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: Colors.transparent,
      elevation: 1.0,
      child: Container(
        margin: EdgeInsets.all(5.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.0),
            Image.asset("images/walker_android.png", width: 120.0,),
            SizedBox(height: 18,),
            Text("New Walk Request", style: TextStyle(fontFamily: "Brand-Bold", fontSize: 18.0,),),
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("images/pickicon.png", height: 16.0, width: 16.0,),
                      SizedBox(width: 20.0,),
                      Expanded(
                        child: Container(child: Text(walkDetails.pickup_address, style: TextStyle(fontSize: 18.0),)),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("images/desticon.png", height: 16.0, width: 16.0,),
                      SizedBox(width: 20.0,),
                      Expanded(
                          child: Text(walkDetails.dropoff_address, style: TextStyle(fontSize: 18.0),)
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.0),
            Divider(height: 2.0, color: Colors.black, thickness: 2.0,),
            SizedBox(height: 8.0),

            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.red)),
                    color: Colors.white,
                    textColor: Colors.red,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {},
                    child: Text(
                      "Cancel".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),

                  SizedBox(width: 25.0,),

                  RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green)),
                      onPressed: () {},
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text("Accept".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                      ),

                ],
              ),
            ),

            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
