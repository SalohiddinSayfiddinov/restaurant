import 'package:flutter/material.dart';
import 'package:restaurant/bg.dart';
import 'package:restaurant/details/view/details.dart';

class HomesScreen extends StatefulWidget {
  const HomesScreen({super.key});

  @override
  State<HomesScreen> createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
  final List<String> categories = [
    "Pizza",
    "Burgers",
    "Sushi",
    "Pasta",
    "Desserts"
  ];
  final Map<String, List<Map<String, String>>> foodItems = {
    "Pizza": [
      {"name": "Pepperoni", "price": "140000 so'm"},
      {"name": "Margarita", "price": "140000 so'm"},
      {"name": "Chickenpizza", "price": "140000 so'm"},
      {"name": "Hawaiian", "price": "100000 so'm"},
      {"name": "Veggie", "price": "90000 so'm"},
      {"name": "Four Cheese", "price": "130000 so'm"},
    ],
    "Burgers": [
      {"name": "Cheeseburger", "price": "14000 so'm"},
      {"name": "Hamburger", "price": "14000 so'm"},
      {"name": "Chickenburger", "price": "14000 so'm"},
      {"name": "Doublecheeseburger", "price": "10000 so'm"},
      {"name": "Veganburger", "price": "9000 so'm"},
      {"name": "Blackburger", "price": "13000 so'm"},
    ],
    "Sushi": [
      {"name": "California", "price": "14000 so'm"},
      {"name": "Roll", "price": "14000 so'm"},
      {"name": "Temaki", "price": "14000 so'm"},
      {"name": "Nigiri", "price": "10000 so'm"},
      {"name": "Uramaki", "price": "9000 so'm"},
      {"name": "Maki", "price": "13000 so'm"},
    ],
    "Pasta": [
      {"name": "Elbow", "price": "140000 so'm"},
      {"name": "Bucatini", "price": "140000 so'm"},
      {"name": "Spaghetti", "price": "140000 so'm"},
      {"name": "Farfalle", "price": "100000 so'm"},
      {"name": "Capellini", "price": "90000 so'm"},
      {"name": "Cavatappi", "price": "130000 so'm"},
    ],
    "Desserts": [
      {"name": "Cake", "price": "140000 so'm"},
      {"name": "Mochi", "price": "140000 so'm"},
      {"name": "Ice Cream", "price": "14000 so'm"},
      {"name": "Baklava", "price": "10000 so'm"},
      {"name": "Éclair", "price": "9000 so'm"},
      {"name": "Croissant", "price": "130000 so'm"},
    ],
  };

  String selectedCategory = "Pizza";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount;
          if (constraints.maxWidth >= 1024) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth >= 768) {
            crossAxisCount = 3;
          } else {
            crossAxisCount = 2;
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.search, color: AppColor.iconcolor),
                        ),
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Yaxshi korgan ovkatini tanla",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: categories.map((category) {
                        return FoodCategoryButton(
                          title: category,
                          isSelected: selectedCategory == category,
                          onTap: () {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: foodItems[selectedCategory]?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = foodItems[selectedCategory]![index];
                      return FoodItemCard(
                          name: item["name"]!, price: item["price"]!);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FoodCategoryButton extends StatelessWidget {
  const FoodCategoryButton(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onTap});
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.white : Colors.white24,
          foregroundColor: isSelected ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  const FoodItemCard({super.key, required this.name, required this.price});
  final String name;
  final String price;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailsScreen(),
            ));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQErkNKMmH0WUulsuEIXxlBzENBKEhcjAkl0g&s",
                  fit: BoxFit.cover,
                  height: 100,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                price,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
