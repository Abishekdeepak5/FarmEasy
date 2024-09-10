import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'FarmEasy',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.home, color: Colors.orange),
            SizedBox(width: 5),
            Text("Home"),
            Spacer(),
            Icon(Icons.person),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddressSection(),
            SearchBarSection(),
            ProductCarousel(),
            CategoryGrid(),
            FarmerDescriptionSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
class AddressSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'A-01 Bank street , new delhi-110096 A-01, Bank street',
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
      ),
    );
  }
}
class SearchBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for Bread',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Icon(Icons.mic),
        ],
      ),
    );
  }
}
class ProductCard extends StatelessWidget {
  final String productName;
  final String price;
  final String imagePath; // Path to local asset image

  ProductCard({
    required this.productName,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            child: Image.asset(imagePath, fit: BoxFit.cover), // Load local image here
          ),
          SizedBox(height: 8),
          Text(
            productName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
class ProductCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ProductCard(
              productName: "Tomato",
              price: "Avg 30/Kg",
              imagePath: "assets/Images/tomato.jpg"
          ),
          ProductCard(
              productName: "Potato",
              price: "Avg 30/Kg",
              imagePath: "assets/Images/potato.jpg"
          ),
          ProductCard(
              productName: "Onion",
              price: "Avg 30/Kg",
              imagePath: "assets/Images/download.jpeg"
          ),
          ProductCard(
              productName: "Garlic",
              price: "Avg 30/Kg",
              imagePath: "assets/Images/garlic.jpeg"
          ),
        ],
      ),
    );
  }
}

class CategoryGrid extends StatelessWidget {
  final List<String> categories = [
    'Fruits', 'Vegetables', 'Rice', 'Cereals', 'Pulses', 'Grains', 'Flowers', 'Plants'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryIcon(category: categories[index]);
        },
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final String category;

  CategoryIcon({required this.category});

  // Function to map category names to image paths
  String _getImageForCategory(String category) {
    switch (category) {
      case 'Fruits':
        return 'assets/Images/fruits.jpeg';
      case 'Vegetables':
        return 'assets/Images/vegetables.jpeg';
      case 'Rice':
        return 'assets/Images/rice.jpeg';
      case 'Cereals':
        return 'assets/Images/cereals.jpg';
      case 'Pulses':
        return 'assets/Images/pulses.jpeg';
      case 'Flowers':
        return 'assets/Images/flowers.jpeg';
      case 'Grains':
        return 'assets/Images/grains.jpeg';
      case 'Plants':
        return 'assets/Images/plants.jpeg';
      default:
        return 'assets/images/default.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('$category clicked');
      },
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(
                _getImageForCategory(category),  // Use image based on category
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            category,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}


class FarmerDescriptionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  color: Colors.grey,
                ),
                SizedBox(width: 16),
                Text(
                  'Farmer Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
    );
  }
}
