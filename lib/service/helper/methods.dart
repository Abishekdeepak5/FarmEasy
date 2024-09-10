import 'package:farmeasy/model/stateIN.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper{
  double findMin(double a,double b){
    return a<b?a:b;
  }
  double findMax(double a,double b){
    return a>b?a:b;
  }
  Future<Location> getLocation() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? state = prefs.getString('state');
    String? district = prefs.getString('district');
    return Location(state:state!,district:district!);
  }
}