import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the ui
  String time; //time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool isDayTime; //true or false if daytime or not

  WorldTime({this.location,this.flag,this.url});


    Future<void> getTime() async {
      try{
        //make the request
        Response response = await get('http://worldtimeapi.org/api/timezone/$url');
        Map data = jsonDecode(response.body);

        //get Properties from data
        String dateTime = data['datetime'];
        String offset = data['utc_offset'].substring(1, 3);
        //print(offset);

        //Create dateTime object
        DateTime now = DateTime.parse(dateTime);
        now = now.add(Duration(hours: int.parse(offset)));

        isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
        time = DateFormat.jm().format(now);
      }
      catch(e){
        time = 'could not get time data';
      }

  }
}
