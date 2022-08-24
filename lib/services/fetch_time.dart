import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class FetchTime{

  late String location; // location name for UI
  late String time; // the time in that location
  late String flag; // url to an asset flag icon
  late String url; // location url for api endpoint
  late bool isDaytime;

  FetchTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {

    try{
      // make the API request
      var furl = Uri.parse( 'http://worldtimeapi.org/api/timezone/$url' );
      http.Response response = await http.get(furl);
      Map data = jsonDecode(response.body);

      // fetch properties from json
      String datetime = data['datetime'];
      String offset_hours = data['utc_offset'].substring(1,3);
      String offset_minutes = data['utc_offset'].substring(4,6);
      // print(data['utc_offset'][0]);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      if(data['utc_offset'][0] == '+')
        now = now.add(Duration(hours: int.parse(offset_hours), minutes: int.parse(offset_minutes)));
      else
        now = now.subtract(Duration(hours: int.parse(offset_hours), minutes: int.parse(offset_minutes)));

      //set the isDaytime property
      isDaytime = now.hour > 6 && now.hour < 19 ? true : false;

      //set the time property
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('Caught error: $e');
      time = 'Could not get time';
    }

  }

}