import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time_app/services/world_time.dart';
class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [];
  bool isLoading = false;

  void getAllLocations() async{
    setState((){isLoading = true;    });
    WorldTime timeLocation = WorldTime(location: '',  picture: '',latitude: '',longitude: '');
    List<WorldTime> allLocation = await timeLocation.getLocations();
   setState(() {
     locations = allLocation;
     isLoading = false;
   });
  }

  void updateTime(int index) async{
    WorldTime worldTime = locations[index];
    await worldTime.getTime();
    if(!context.mounted)return;
    Navigator.pop(context,{
          "location":worldTime.location,
          "time":worldTime.time,
          "picture":worldTime.picture,
          "isDayTime": worldTime.isDayTime,
        });
  }

  @override
  void initState() {
    super.initState();
    getAllLocations();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Location"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: isLoading?  Center(
        child: SpinKitDoubleBounce(
          color: Colors.purpleAccent,
          size: 60.0,
        ),
      ):
      ListView.builder(
        itemCount: locations.length,
          itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical:1, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(locations[index].picture),
                ),
              ),
            ),
          );
      })
    );
  }
}

