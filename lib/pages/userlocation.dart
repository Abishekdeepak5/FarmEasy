import 'package:farmeasy/api/govdata.dart';
import 'package:flutter/material.dart';
import 'package:farmeasy/pages/products.dart';
import 'package:farmeasy/model/stateIN.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CheckLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkStoredData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data as bool) {
            return ProductPage(); // Navigate to HomeScreen if data exists
          } else {
            return UserLocation(); // Show InputScreen if no data
          }
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Future<bool> _checkStoredData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedData1 = prefs.getString('state');
    String? storedData2 = prefs.getString('district');
    return storedData1 != null && storedData2 != null;
  }
}


class UserLocation extends StatefulWidget {
  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation>{
  String? _selectedState;
  String? _selectedDistrict;
  List<StateIN> states = [];
  List<String> districts = [];

  // Navigate to the next page
  void _navigateToNextPage() async{
    if (_selectedState!= null && _selectedDistrict != null) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('state', _selectedState!);
                await prefs.setString('district', _selectedDistrict!);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPage()),
                );

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ProductPage()),
      // );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both state and district')),
      );
    }
  }

  @override
  void initState(){
    super.initState();
    _loadStates();
  }

  void _loadStates() async{
    states = await ApiService().loadStatesAndDistricts();
    setState(() {});
  }

  // Update districts when a state is selected
  void _onStateChanged(String? selectedState) {
    setState(() {
      _selectedState = selectedState;
      _selectedDistrict = null; // Reset district selection
      districts = states
          .firstWhere((state) => state.name == selectedState)
          .districts; // Update the district list based on selected state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Farmeasy'),
      ),
      body: states.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Select your state:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  // State Dropdown
                  DropdownButton<String>(
                    value: _selectedState,
                    hint: Text('Choose a state'),
                    isExpanded: true,
                    items: states.map((StateIN state) {
                      return DropdownMenuItem<String>(
                        value: state.name,
                        child: Text(state.name),
                      );
                    }).toList(),
                    onChanged: _onStateChanged,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Select your district:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  // District Dropdown (enabled only when a state is selected)
                  DropdownButton<String>(
                    value: _selectedDistrict,
                    hint: Text('Choose a district'),
                    isExpanded: true,
                    items: districts.isNotEmpty
                        ? districts.map((String district) {
                            return DropdownMenuItem<String>(
                              value: district,
                              child: Text(district),
                            );
                          }).toList()
                        : [], // Show empty list if no districts available
                    onChanged: districts.isNotEmpty
                        ? (newValue) {
                            setState(() {
                              _selectedDistrict = newValue;
                            });
                          }
                        : null, // Disable if no districts available
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _navigateToNextPage,
                    child: Text('Next'),
                  ),
                ],
              ),
            ),
    );
  }
}
