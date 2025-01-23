import 'package:flutter/material.dart';
import 'package:m_espresso_v1/data/tmp_data.dart';
import 'package:m_espresso_v1/entities/coffee.dart';
import 'package:m_espresso_v1/ui/theme/app_theme.dart';
import 'package:m_espresso_v1/ui/screens/screens.dart';
// import 'package:m_espresso_v1/ui/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Coffee> pendingPayments = [];
  String selectedCategory = 'All';
  Map<int, int> itemQuantities = {};

  void updateQuantity(Coffee coffee, int delta) {
    setState(() {
      itemQuantities[coffee.id] = (itemQuantities[coffee.id] ?? 0) + delta;
      if (itemQuantities[coffee.id]! <= 0) {
        itemQuantities.remove(coffee.id);
      }
    });
  }

  void addToPendingPayments(Coffee coffee) {
    if (itemQuantities[coffee.id] == null || itemQuantities[coffee.id]! <= 0)
      return;

    setState(() {
      final quantity = itemQuantities[coffee.id] ?? 0;
      for (var i = 0; i < quantity; i++) {
        pendingPayments.add(coffee);
      }
      itemQuantities.remove(coffee.id);
    });

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('${coffee.name} added to pending payments!')),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Apptheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 22, top: 30, right: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Text('Menu Items', style: Apptheme.tileLarge),
              const SizedBox(height: 28),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: DataTmp.coffeeList.length,
                  itemBuilder: (context, index) {
                    final coffee = DataTmp.coffeeList[index];
                    return EnhancedMenuItemCard(
                      coffee: coffee,
                      quantity: itemQuantities[coffee.id] ?? 0,
                      onIncrementQuantity: () => updateQuantity(coffee, 1),
                      onDecrementQuantity: () => updateQuantity(coffee, -1),
                      onAddToPending: () => addToPendingPayments(coffee),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PendingPaymentsScreen(pendingPayments: pendingPayments),
            ),
          );
        },
        label: Text('Confirm (${pendingPayments.length})'),
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

class EnhancedMenuItemCard extends StatelessWidget {
  final Coffee coffee;
  final int quantity;
  final VoidCallback onIncrementQuantity;
  final VoidCallback onDecrementQuantity;
  final VoidCallback onAddToPending;

  const EnhancedMenuItemCard({
    Key? key,
    required this.coffee,
    required this.quantity,
    required this.onIncrementQuantity,
    required this.onDecrementQuantity,
    required this.onAddToPending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Apptheme.cardChipBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              coffee.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(coffee.name, style: Apptheme.cardTitleSmall),
                const SizedBox(height: 4),
                Text('\$${coffee.price.toStringAsFixed(2)}',
                    style: Apptheme.priceValueSmall),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline,
                              color: Apptheme.buttonBackground1Color),
                          onPressed: quantity > 0 ? onDecrementQuantity : null,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child:
                              Text('$quantity', style: Apptheme.cardTitleSmall),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline,
                              color: Apptheme.buttonBackground1Color),
                          onPressed: onIncrementQuantity,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    if (quantity > 0)
                      IconButton(
                        icon: const Icon(Icons.add_task_rounded),
                        onPressed: onAddToPending,
                        color: Apptheme.buttonBackground1Color,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
