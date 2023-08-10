



import 'dart:convert';

import 'package:covid_tracker/utiles/app_uri.dart';

import '../modal/WorldStateModal.dart';
import 'package:http/http.dart'as http;

class StateServices {

  Future<WorldStateModal> fatchWorldStateModalRecords() async{

    final response = await http.get(Uri.parse(AppUri.worldStateApi));

    if(response.statusCode == 200)
      {
        var data = jsonDecode(response.body);
        return WorldStateModal.fromJson(data);
      }else
        {
          throw Exception('Error');
        }
  }


  Future<List<dynamic>> countrieslistApi() async{

    var data;
    final response = await http.get(Uri.parse(AppUri.countriestList));

    if(response.statusCode == 200)
    {
       data = jsonDecode(response.body);
      return data;
    }else
    {
      throw Exception('Error');
    }
  }
}