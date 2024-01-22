import 'package:flutter/material.dart';
import 'package:videocall/screen/joinmeetscreen.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:videocall/resource/util.dart';

class CallPage extends StatelessWidget {
  CallPage(
      {Key? key,
      required this.callID,
      required this.userid,
      required this.username})
      : super(key: key);
  final String callID;
  final String userid;
  final String username;
  final Util util = Util();

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      events: ZegoUIKitPrebuiltCallEvents(
        onCallEnd: (event, defaultAction) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return joinmeetscreen();
              },
            ),
          );
        },
      ),
      appID: util
          .appid, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: util
          .appsign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userid,
      userName: username,
      callID: callID,
      //callid is basically room number
      //for one emailid, appid and appsign is alloted
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.groupVideoCall(),
    );
  }
}
