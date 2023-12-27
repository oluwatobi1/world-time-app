import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty? data: ModalRoute.of(context)?.settings.arguments as Map;
    String bgImage = data["isDayTime"] ? "assets/day.jpg" : "assets/night.jpg";
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
                image: AssetImage(bgImage),
            fit: BoxFit.cover,
              ),


          ),
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120.0, 0.0, 0),
              child: Column(
                children: [
                  OutlinedButton.icon(
                    onPressed: () async {
                  dynamic result = await Navigator.pushNamed(context, "/location");
                  setState(() {
                    data = result;
                  });
                },
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(
                            color: Colors.white,
                    width: 1.0,
                    style: BorderStyle.solid))),
                    icon: Icon(
                        Icons.add_location,
                      color: Colors.white,

                    ),
                    label: Text(
                        "Choose Location",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
              ),
                  SizedBox(height: 20.0),
                 Image(
                     image:  NetworkImage(data["picture"]),
                   width: 100.0,
                 ),
                  SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data["location"],
                    style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                data["time"],
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
