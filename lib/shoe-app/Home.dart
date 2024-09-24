import 'package:flutter/material.dart';
import 'Details.dart';
import 'CartModel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> shoes = [
    {'name': 'Nike', 'image': 'assets/images/two.jpg', 'price': '50'},
    {'name': 'Salomon', 'image': 'assets/images/three.jpg', 'price': '80'},
    {'name': 'Run', 'image': 'assets/images/six.jpg', 'price': '40'},
    {'name': 'Addidas', 'image': 'assets/images/seven.jpg', 'price': '60'},
    {'name': 'Jordan', 'image': 'assets/images/one.jpg', 'price': '90'},
    {'name': 'Air', 'image': 'assets/images/ten.jpg', 'price': '70'},
  ];

  final List<Color> cardColors = [
    const Color.fromARGB(255, 6, 170, 211),
    const Color.fromARGB(255, 239, 242, 239),
    const Color.fromARGB(255, 251, 186, 6),
    const Color.fromARGB(255, 156, 238, 41),
    const Color.fromARGB(255, 212, 18, 18),
    const Color.fromARGB(255, 229, 190, 230),
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shadowColor: const Color.fromARGB(255, 7, 255, 181),
        backgroundColor: const Color.fromARGB(226, 23, 32, 36),
        centerTitle: true,
        title: const Text('Shoe Store',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 98, 246, 214),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'assets/images/backk.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView.builder(
            itemCount: shoes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final shoe = Shoe(
                    name: shoes[index]['name']!,
                    imageUrl: shoes[index]['image']!,
                    price: double.parse(shoes[index]['price']!),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShoeDetailsPage(shoe: shoe),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(1),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: cardColors[index % cardColors.length],
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                height: 200,
                                width: 200,
                                shoes[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shoes[index]['name']!,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '\$${shoes[index]['price']}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
