import 'package:flutter/material.dart';

void main() {
  runApp(FormeasyApp());
}

class FormeasyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formeasy',
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

class _HomePageState extends State<HomePage> {
  String? _selectedState;

  final List<String> _indianStates = [
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
  ];

  void _navigateToNextPage() {
    if (_selectedState != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CustomerRetailerPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Formeasy'),
      ),
      body: Padding(
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
            DropdownButton<String>(
              value: _selectedState,
              hint: Text('Choose a state'),
              isExpanded: true,
              items: _indianStates.map((String state) {
                return DropdownMenuItem<String>(
                  value: state,
                  child: Text(state),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedState = newValue;
                });
              },
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
