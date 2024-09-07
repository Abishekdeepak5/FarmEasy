import 'package:farmeasy/api/govdata.dart';
import 'package:flutter/material.dart';
import 'package:farmeasy/components/products.dart';
import 'package:farmeasy/model/stateIN.dart';


void main() {
  runApp(FarmeasyApp());
}

class FarmeasyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmeasy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  String? _selectedState;
  String? _selectedDistrict;
  List<StateIN> states = [];
  List<String> districts = [];

  /*final List<String> _indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];*/

  // Navigate to the next page
  void _navigateToNextPage() {
    if (_selectedState != null && _selectedDistrict != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductPage()),
      );
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

class CustomerRetailerPage extends StatefulWidget {
  @override
  _CustomerRetailerPageState createState() => _CustomerRetailerPageState();
}

class _CustomerRetailerPageState extends State<CustomerRetailerPage> {
  String? _selectedRole;

  final List<String> _roles = ['Customer', 'Retailer'];

  void _submit() {
    if (_selectedRole != null) {
      // Implement what happens after selection
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You selected $_selectedRole')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Are you a Customer or Retailer?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select your role:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedRole,
              hint: Text('Choose a role'),
              isExpanded: true,
              items: _roles.map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedRole = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Back'),
        ),
      ),
    );
  }
}
