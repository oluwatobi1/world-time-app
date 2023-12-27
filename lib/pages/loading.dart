import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time_app/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    WorldTime worldTime = WorldTime(location: "Nigeria", picture: "https://flagcdn.com/w320/ng.png", latitude: "-15.79", longitude: "-47.88");
    await worldTime.getTime();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(
        context,
        "/home",
        arguments: {
          "location":worldTime.location,
          "time":worldTime.time,
          "picture":worldTime.picture,
          "isDayTime": worldTime.isDayTime,
        });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Center(
          child: SpinKitRotatingCircle(
            color: Colors.purpleAccent,
            size: 100.0,
          ),
      )
      ),
    );
  }
}
