import 'dart:convert';
import 'package:farmeasy/service/helper/methods.dart';
import 'package:http/http.dart' as http;
import 'package:farmeasy/model/product.dart';
import 'package:farmeasy/model/stateIN.dart';

class ApiService {
  // String apiUrl = 'https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd00000128adeb03b15f484e437fd9f419d59c4a&format=json&offset=21&limit=21&filters%5Bstate.keyword%5D=Tamil%20Nadu&filters%5Bdistrict%5D=Thirunelveli';
  String apiUrl = "https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd00000128adeb03b15f484e437fd9f419d59c4a&format=json&limit=10";
  // String commodity="";
  Helper helper=new Helper();
  // Fetch only the Products part from API response
  Future<List<Product>> getProducts() async {
    Location location=await helper.getLocation();
    String url=apiUrl+"&filters%5Bstate.keyword%5D=${Uri.encodeFull(location.state)}&filters%5Bdistrict%5D=${Uri.encodeFull(location.district)}";
    final response = await http.get(Uri.parse(url));

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

  Future<List<Product>> getCommodity(String commodity) async {
    Location location=await helper.getLocation();
    String url=apiUrl+"&filters%5Bstate.keyword%5D=${Uri.encodeFull(location.state)}&filters%5Bdistrict%5D=${Uri.encodeFull(location.district)}";
    url+="&filters%5Bcommodity%5D=${Uri.encodeFull(commodity)}";
    final response = await http.get(Uri.parse(url));

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
}
