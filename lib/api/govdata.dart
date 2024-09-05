import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:farmeasy/model/product.dart';
import 'package:farmeasy/model/stateIN.dart';
import 'package:flutter/services.dart'; // For loading asset file

class ApiService {
  final String apiUrl = 'https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd00000128adeb03b15f484e437fd9f419d59c4a&format=json&offset=21&limit=21&filters%5Bstate.keyword%5D=Kerala&filters%5Bdistrict%5D=thiruvananthapuram';

  // Fetch only the Products part from API response
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parse the response body
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Extract the Products part
      List<dynamic> ProductsJson = jsonResponse['records'];

      // Convert JSON to List<Product>
      return ProductsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Products');
    }
  }

  Future<List<StateIN>> loadStatesAndDistricts() async {
  // Load the JSON file from assets
  String jsonString = await rootBundle.loadString('assets/states-and-districts.json');

  // Decode the JSON string into a map
  Map<String, dynamic> jsonMap = json.decode(jsonString);

  // Convert the JSON to a list of State objects
  List<StateIN> states = (jsonMap['states'] as List)
      .map((stateJson) => StateIN.fromJson(stateJson))
      .toList();

  return states;
}

}
