import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

const String kOpenMapBaseURL = 'https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {

  Future<dynamic> getWeatherData() async {
    Location location = Location();
    NetworkHelper networkHelper = NetworkHelper();
    await location.getCurrentLocation();
    var weatherData = await networkHelper.executeGet(
        '$kOpenMapBaseURL?lat=${location.lattitude}&lon=${location.longtitude}&appid=$kOpenWeatherKey&units=metric');

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future<dynamic> getWeatherDataByCity(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper();
    var weatherData = await networkHelper.executeGet(
        '$kOpenMapBaseURL?q=$cityName&appid=$kOpenWeatherKey&units=metric');

    return weatherData;
  }
}
