import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/model.dart';

class CoffeeCubit extends Cubit<List<Coffee>> {
  CoffeeCubit()
      : super([
          Coffee(
            name: "CHeeseburgers",
            image: "assets/images/Rectangle 20.png",
            price: 20000,
          ),
          Coffee(
              name: "Ham Sendwiches",
              image: "assets/images/Rectangle 22.png",
              price: 18000),
          Coffee(
              name: "Chicken Pitas",
              image: "assets/images/Rectangle 23.png",
              price: 19000),
        ]);

  void incrementQuantity(int index) {
    state[index].quantity++;
    emit(List.from(state));
  }

  void decrementQuantity(int index) {
    if (state[index].quantity > 1) {
      state[index].quantity--;
      emit(List.from(state));
    }
  }

  void removeItem(int index) {
    state.removeAt(index);
    emit(List.from(state));
  }

  int calculateTotal() {
    final total =
        state.fold(0, (sum, coffee) => sum + (coffee.price * coffee.quantity));
    return total + 4900 + 6487;
  }
}

class CoffeeCartScreen extends StatelessWidget {
  const CoffeeCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          color: Colors.grey[900],
          iconSize: 30,
          onPressed: () {
           
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[900],
        ),
        child: BlocBuilder<CoffeeCubit, List<Coffee>>(
          builder: (context, coffeeList) {
            if (coffeeList.isEmpty) {
              return const Center(
                child: Text(
                  "Savat bo'sh !",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: coffeeList.length,
                    itemBuilder: (context, index) {
                      final coffee = coffeeList[index];
                      return Dismissible(
                        key: Key(coffee.name),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          context.read<CoffeeCubit>().removeItem(index);
                        },
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          color: Colors.blueGrey[700],
                          child: ListTile(
                            leading: Image.asset(coffee.image,
                                width: 50, height: 50),
                            title: Text(
                              coffee.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "Narxi: ${coffee.price} so'm",
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.normal),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  color: Colors.grey[900],
                                  onPressed: () => context
                                      .read<CoffeeCubit>()
                                      .decrementQuantity(index),
                                ),
                                Text(
                                  coffee.quantity.toString(),
                                  style: TextStyle(color: Colors.grey[900]),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  color: Colors.grey[900],
                                  onPressed: () => context
                                      .read<CoffeeCubit>()
                                      .incrementQuantity(index),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.blueGrey[900],
                    child: Column(children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Yetkazib berish:",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          Text("4900 so'm",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Soliq:",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.white)),
                            Text("6487 so'm",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.white)),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Umumiy to'lov:",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text(
                              "${context.read<CoffeeCubit>().calculateTotal()} so'm",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                    
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: const BorderSide(color: Colors.white)),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            'Buyurtma Berish',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ])),
              ],
            );
          },
        ),
      ),
    );
  }
}
