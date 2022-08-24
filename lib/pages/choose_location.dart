import 'package:flutter/material.dart';
import 'package:world_time/services/fetch_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<FetchTime> locations = [
    FetchTime(url: 'Asia/Kolkata', location: 'Kolkata', flag: 'india.jpeg'),
    FetchTime(url: 'Europe/London', location: 'London', flag: 'uk.jpeg'),
    FetchTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'germany.jpeg'),
    FetchTime(url: 'Europe/Athens', location: 'Athens', flag: 'greece.jpeg'),
    FetchTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.jpeg'),
    FetchTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.jpeg'),
    FetchTime(url: 'America/New_York', location: 'New York', flag: 'usa.jpeg'),
    FetchTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.jpeg'),
    FetchTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.jpeg'),
  ];

  void updateTime(index) async {
    FetchTime instance = locations[index];
    await instance.getTime();

    // navigate to Home screen
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text("Choose Location"),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
