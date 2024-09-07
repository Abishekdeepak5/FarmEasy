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

  @override
  void initState() {
    super.initState();
    // futureProducts = ApiService().getProducts();
    // ProductService productService=new ProductService();
    futureProducts=ProductService().getFrequentProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index].commodity),
                  subtitle: Text('Avg: ₹ ${products[index].modalPrice}(${products[index].minPrice}-${products[index].maxPrice})'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
