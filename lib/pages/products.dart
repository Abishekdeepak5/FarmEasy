import 'package:farmeasy/model/stateIN.dart';
import 'package:farmeasy/pages/userlocation.dart';
import 'package:farmeasy/service/helper/methods.dart';
import 'package:farmeasy/service/productservice.dart';
import 'package:flutter/material.dart';
import 'package:farmeasy/service/api/govdata.dart';
import 'package:farmeasy/model/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<Product>> futureProducts;
  late Future<Location> location;
  @override
  void initState(){
    super.initState();
    futureProducts=ProductService().getFrequentProduct();
  }
  void getlocation(){
    Helper helper=new Helper();
    location=helper.getLocation();
    // print(location?.district);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title:Text("Home")
        // title: Text('Home ${location!.state} ${location!.district}'),
        title:LocationScreen(),
      ),
      body:Column(
        children: [
         Expanded(child:
          AveragePrice(futureProducts: futureProducts)
         )
        ],
      )
    );
  }
}


// Modular CustomCard Widget
class AveragePrice extends StatelessWidget {
  final Future<List<Product>> futureProducts;

  const AveragePrice({
    super.key,
    required this.futureProducts,
  });

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = snapshot.data!;
            return 
            Column(children: <Widget>[
            ElevatedButton(onPressed: ()=>{
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserLocation()),
                  )
            }, child: Text("Edit Location")),
            Expanded(
            child:ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index].commodity),
                  subtitle: Text('Avg: ₹ ${products[index].modalPrice}(${products[index].minPrice}-${products[index].maxPrice})'),
                );
              },
            ),)
            ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      );
    }
}


class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late Future<Location> locationData;

  @override
  void initState() {
    super.initState();
    Helper helper=new Helper();
    locationData = helper.getLocation(); // Fetching location when widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Location>(
          future: locationData, // The Future that contains the location data
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator while waiting
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Handle errors
            } else if (snapshot.hasData) {
              return Text('State: ${snapshot.data!.state}\nDistrict: ${snapshot.data!.district}'); // Show location data
            } else {
              return Text('No data available');
            }
          },
        );
  }
}