import 'dart:convert';
import 'package:farmeasy/service/api/govdata.dart';
import 'package:farmeasy/service/helper/methods.dart';
import 'package:http/http.dart' as http;
import 'package:farmeasy/model/product.dart';

class ProductService {
  ApiService api=new ApiService();
  Helper helper=new Helper();
  List<String> commodities=['Lemon','Banana','brinjal','tomato','apple'];

  Future<List<Product>> getFrequentProduct() async {
    List<Product> frequentProduct=[];
    for(String commodity in commodities){
      List<Product> products=await api.getCommodity(commodity);
      int count=products.length;
      double totAverage=0;
      if(count>0){
      double minPrice=products[0].minPrice;
      double maxPrice=0;
        Product currProduct=new Product( 
                              state:products[0].state,
                              district:products[0].district,
                              market:products[0].market,
                              commodity:products[0].commodity,
                              variety:products[0].variety,
                              grade:products[0].grade,
                              arrivalDate:products[0].arrivalDate,
                              minPrice:products[0].minPrice,
                              maxPrice:products[0].maxPrice,
                              modalPrice:0);
        for(Product product in products){
          totAverage+=(product.minPrice)+((product.maxPrice-product.maxPrice)/2);
          minPrice=helper.findMin(minPrice,product.minPrice);
          maxPrice=helper.findMax(maxPrice,product.maxPrice);
        }
        currProduct.modalPrice=(totAverage/count as double)/100;
        currProduct.minPrice=minPrice/100;
        currProduct.maxPrice=maxPrice/100;
          frequentProduct.add(currProduct);

      }
    }
    return frequentProduct;
  }
}
