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
      // Notify the parent (HomeScreen) about the updated list
      widget.onPendingPaymentsUpdated?.call(_pendingPayments);
    });
  }

  void _onConfirmPressed(BuildContext context) {
    // Notify the parent (HomeScreen) that the payment is confirmed
    widget.onPendingPaymentsUpdated?.call([]); // Clear the list
    Navigator.pop(context); // Go back to the HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
        title: const Text('M Espresso'),
        backgroundColor: Apptheme.buttonBackground1Color,
      ),
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
                        'ETB${totalAmount.toStringAsFixed(2)}',
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
                          return KeyedSubtree(
                            child: Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(Icons.check,
                                    color: Colors.green),
                              ),
                              onDismissed: (_) => _removeItem(index),
                              child: Card(
                                color: Apptheme.cardChipBackgroundColor,
                                shape: RoundedRectangleBorder(
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
                                    'ETB${coffee.price.toStringAsFixed(2)}',
                                    style: Apptheme.priceValueSmall,
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.check_box),
                                    onPressed: () => _removeItem(index),
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              if (_pendingPayments.isNotEmpty)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  color: Apptheme.backgroundColor,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _onConfirmPressed(context),
                      icon: const Icon(Icons.check),
                      label: const Text('Confirm Payment'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Apptheme.buttonBackground1Color,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
