import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/Model/weather_model.dart';

class MyController extends GetxController {
  var weatherData = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWeatherData();
  }


  fetchWeatherData() async {
    final apiKey = '60a7bba09310b718ada33214a71ad2a7';
    final apiUrl = 'https://api.openweathermap.org/data/2.5/forecast?q=Mumbai&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      var list = [];

     for(int i = 0; i < json['list'].length; i++)
       {
         if(DateFormat('EEE').format(DateTime.parse(json['list'][i]['dt_txt'])).toString() == "Sun")
         {
           break;
         }

         list.add(Weather(
             day: DateFormat('EEE').format(DateTime.parse(json['list'][i]['dt_txt'])),
             temperature: json['list'][i]['main']['temp'].round(),
             conditions: json['list'][i]['weather'][0]['main'],
             dateTime: json['list'][i]['dt_txt'].toString()
         ));
       }


     weatherData.value = list;


    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
