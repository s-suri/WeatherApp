import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/Repo/weather_respo.dart';

class MyPage extends StatelessWidget {
  final MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App (mumbai)'),
        actions: [
          Container(
            child: IconButton(icon: Icon(Icons.feedback),onPressed: ()
            {
              _openUrl('mailto:edurathore@gmail.com');
            },
            ),
          )
        ],
      ),
      body: Center(
        child: Obx(() => ListView.builder(
          itemCount: myController.weatherData.length,
          itemBuilder: (context, index) {
            final weather = myController.weatherData[index];
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${weather.day}"),
                  SizedBox(width: 15,),
                  Text("${weather.dateTime}",style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54
                  ),),
                ],
              ),
              subtitle: Text('${weather.temperature}°C, ${weather.conditions}'),
            );
          },
        )),
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}