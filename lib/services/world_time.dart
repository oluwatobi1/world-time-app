import 'package:http/http.dart' as http;
import "dart:convert";

import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String longitude;
  late String latitude;
  late String time;
  late String picture;
  late bool isDayTime;


  WorldTime({required this.location, required this.picture, required this.latitude, required this.longitude});


  Future<void> getTime() async {
    try {
      Map<String, String> params = {"latitude": latitude, "longitude":longitude};
      //https://timeapi.io/api/Time/current/coordinate?latitude=42.5&longitude=1.52
      var url = Uri.https("timeapi.io", "api/Time/current/coordinate", params);
      http.Response response = await http.get(url);
      Map data = jsonDecode(response.body);
      DateTime now = DateTime.parse(data['dateTime']);
      time = DateFormat.jm().format(now);
      isDayTime = now.hour > 6 && now.hour < 20;
    } catch (e) {
      print("caught error here $e");
      time = "failed to fetch time data";
    }
  }

  Future<List<WorldTime>> getLocations() async{
    List<WorldTime> locations = [];
    try{
      // https://restcountries.com/v3.1/all
      var url = Uri.https("restcountries.com","v3.1/all");
      http.Response response = await http.get(url);
      List<dynamic> data = jsonDecode(response.body);

      locations = data.map((d)  {
        String picture = d["flags"]["png"];
        String location = d["name"]["common"];
        String latitide = d["latlng"][0].toString();
        String longitude = d["latlng"][1].toString();
      return WorldTime(location: location, picture: picture, latitude: latitide, longitude: longitude);
      }).toList();

    }catch (e){
      print("failed to fetch location $e");
    }
    return locations;

  }
}
