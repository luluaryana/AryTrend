import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin/screens/signin_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filters = const [
    "All",
    "Dresses",
    "Tops",
    "Jeans",
    "Jackets",
    "Shoes",
    "Accessories",
    "Bags",
    "Sweaters",
    "Skirts",
    "Pants"
  ];

  late String selectedFilter;

  // Mock data for fashion clothing items
  final List<Map<String, dynamic>> clothItems = [
    {"name": "Elegant Summer Dress", "price": 79.99, "image": "../assets/images/summer_dress.webp"},
    {"name": "Casual Denim Jacket", "price": 59.99, "image": "../assets/images/denim_jacket.jpg"},
    {"name": "Classic White Shirt", "price": 29.99, "image": "../assets/images/white_shirt.jpg"},
    {"name": "Trendy Leather Bag", "price": 129.99, "image": "../assets/images/leather_bag.jpg"},
    {"name": "Chic Ankle Boots", "price": 89.99, "image": "../assets/images/ankle_boot.jpg"},
    {"name": "Fashion Boots", "price": 90.99, "image": "../assets/images/boots.jpg"},
  ];

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AryTrend", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink[400],
        actions: [
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then(
                (value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SigninScreen(),
                    ),
                  );
                },
              ).onError((error, stackTrace) {
                print("Error ${error.toString()}");
              });
            },
            child: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search, color: Colors.pink[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.pink[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.pink[200]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.pink[400]!),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: selectedFilter == filter,
                      onSelected: (selected) {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      backgroundColor: Colors.pink[50],
                      selectedColor: Colors.pink[400],
                      labelStyle: TextStyle(
                        color: selectedFilter == filter ? Colors.white : Colors.pink[400],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8, // Adjust this value to reduce image height
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: clothItems.length,
                itemBuilder: (context, index) {
                  return _buildClothCard(clothItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClothCard(Map<String, dynamic> item) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 100, // You can adjust this height to reduce the image size
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: AssetImage(item['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '\$${item['price']}',
                  style: TextStyle(color: Colors.pink[400], fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
