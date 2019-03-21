
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hub_weather/weather/WeatherData.dart';
import 'package:http/http.dart' as http;

class WeatherWidget extends StatefulWidget{
  String cityName;

  WeatherWidget(this.cityName);

  @override
  State<StatefulWidget> createState() {
    return new WeatherState(this.cityName);
  }
}

class WeatherState extends State<WeatherWidget> {

  String cityName;
  WeatherData weatherData = WeatherData.empty();

  WeatherState(String cityName) {
    this.cityName = cityName;
    _getWeather();
  }

  void _getWeather() async{
    WeatherData data = await _fetchWeather();
    setState(() {
      weatherData = data;
    });
  }

  Future<WeatherData> _fetchWeather() async{
    final response = await http.get('https://free-api.heweather.net/s6/weather/now?location='+this.cityName+'&key=3fb30b0312ab4493a7d77ccfeb0d6a4e');
    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    }else {
      return WeatherData.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image.asset("images/weather_bg.jpg", fit: BoxFit.fitHeight,),
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 40.0),
                child: new Text(this.cityName, textAlign: TextAlign.center, style: new TextStyle(color: Colors.white, fontSize: 30.0,),),
              ),
              new Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 100.0),
                child: new Column(
                  children: <Widget>[
                    new Text(weatherData?.tmp, style: new TextStyle(color: Colors.white, fontSize: 80.0),),
                    new Text(weatherData?.cond, style: new TextStyle(color: Colors.white, fontSize: 45.0),),
                    new Text(weatherData?.hum, style: new TextStyle(color: Colors.white, fontSize: 30.0),)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}