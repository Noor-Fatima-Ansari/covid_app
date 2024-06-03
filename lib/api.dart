import 'dart:convert';
import 'package:covid_app/ApiModal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class ApiVar{
  static const String baseUrl ='https://disease.sh/v3/covid-19/' ;
   static const String WorldUrl= baseUrl+ 'all';
  static const String CountryUrl= baseUrl+ 'countries';
}


class ApiDeclare {
  Future<ApiModal> callRecord() async{
    final response=await http.get(Uri.parse(ApiVar.WorldUrl));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      return ApiModal.fromJson(data);
    }else{
      throw Exception('Error');
    }

  }

}



class ApiCountries{
  Future<List<dynamic>> countryRecord() async{
    final response=await http.get(Uri.parse(ApiVar.CountryUrl));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Error');
    }

  }
}
