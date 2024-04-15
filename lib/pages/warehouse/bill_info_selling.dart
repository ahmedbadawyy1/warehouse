import 'package:flutter/material.dart';

import '../../models/warehouse_models/bill_info_selling_response_model.dart';

class BillInfoSelling extends StatelessWidget {
  final List<BillInfoSellingResponseModel>? billInfoList;
  final BillInfoSellingResponseModel? billInfo;

  const BillInfoSelling({
    Key? key,
    this.billInfoList,
    this.billInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (billInfo == null || billInfoList == null || billInfoList!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Bill Information'),
        ),
        body: Center(
          child: Text('Failed to load bill information.'),
        ),
      );
    }

    // Build your UI using billInfo and billInfoList
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Information'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: billInfoList!.length,
              itemBuilder: (BuildContext context, int index) {
                BillInfoSellingResponseModel billInfo = billInfoList![index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      'Bill Number: ${billInfo.billNum}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product ID: ${billInfo.productID}'),
                        Text('Quantity: ${billInfo.quantity}'),
                        Text('Cost: ${billInfo.cost}'),
                        // Add more Text widgets to display other fields as needed
                      ],
                    ),
                    onTap: () {
                      // Handle tap on each item if needed
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total:  ${billInfo?.total}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  int calculateTotalCost() {
    int totalCost = 0;
    for (var item in billInfoList!) {
      totalCost += item.cost ?? 0;
    }
    return totalCost;
  }
}
