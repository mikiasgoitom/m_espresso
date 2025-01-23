import 'package:flutter/material.dart';
import 'package:m_espresso_v1/entities/coffee.dart';
import 'package:m_espresso_v1/ui/theme/app_theme.dart';

class PendingPaymentsScreen extends StatefulWidget {
  final List<Coffee> pendingPayments;
  final Function(List<Coffee>)? onPendingPaymentsUpdated;

  const PendingPaymentsScreen({
    Key? key,
    required this.pendingPayments,
    this.onPendingPaymentsUpdated,
  }) : super(key: key);

  @override
  State<PendingPaymentsScreen> createState() => _PendingPaymentsScreenState();
}

class _PendingPaymentsScreenState extends State<PendingPaymentsScreen> {
  late List<Coffee> _pendingPayments;
  double get totalAmount => _pendingPayments.fold(
        0,
        (sum, coffee) => sum + coffee.price,
      );

  @override
  void initState() {
    super.initState();
    _pendingPayments = List.from(widget.pendingPayments);
  }

  void _removeItem(int index) {
    setState(() {
      _pendingPayments.removeAt(index);
      widget.onPendingPaymentsUpdated?.call(_pendingPayments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Apptheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pending Payments', style: Apptheme.tileLarge),
              const SizedBox(height: 20),
              if (_pendingPayments.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Apptheme.cardChipBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Amount:', style: Apptheme.cardTitleSmall),
                      Text(
                        '\$${totalAmount.toStringAsFixed(2)}',
                        style: Apptheme.priceValueSmall.copyWith(
                          color: Apptheme.buttonBackground1Color,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              Expanded(
                child: _pendingPayments.isEmpty
                    ? Center(
                        child: Text(
                          'No pending payments',
                          style: Apptheme.cardTitleSmall,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _pendingPayments.length,
                        itemBuilder: (context, index) {
                          final coffee = _pendingPayments[index];
                          return Dismissible(
                            key: Key('${coffee.id}_$index'),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child:
                                  const Icon(Icons.delete, color: Colors.red),
                            ),
                            onDismissed: (_) => _removeItem(index),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Apptheme.cardChipBackgroundColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    coffee.imageUrl,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  coffee.name,
                                  style: Apptheme.cardTitleSmall,
                                ),
                                subtitle: Text(
                                  '\$${coffee.price.toStringAsFixed(2)}',
                                  style: Apptheme.priceValueSmall,
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () => _removeItem(index),
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
