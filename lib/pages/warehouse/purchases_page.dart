import 'package:flutter/material.dart';
import 'package:warehousse33/pages/warehouse/bill_info_purchases.dart';
import '../../models/warehouse_models/bill_info_purchases_response_model.dart';
import '../../models/warehouse_models/purchases_response_model.dart';
import '../../services/apiservices.dart';


class PurchasesPage extends StatefulWidget {
  const PurchasesPage({Key? key}) : super(key: key);

  @override
  State<PurchasesPage> createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  final APIService apiService = APIService();
  List<PurchasesResponseModel> bills = [];
  List<PurchasesResponseModel> filteredBills = []; // Add a filtered list

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBills();
  }


  Future<void> fetchBills() async {
    try {
      List<PurchasesResponseModel> fetchedBills = await apiService.fetchBills(); // Changed method call to fetch bills
      setState(() {
        bills = fetchedBills;
        filteredBills = List.from(bills);
      });
    } catch (e) {
      print('Error fetching bills: $e');
    }
  }
  Future<List<BillInfoResponseModel>> fetchBillInfo(int billNumber) async {
    try {
      List<BillInfoResponseModel> billInfoList = await apiService.fetchBillInfo(billNumber);
      return billInfoList;
    } catch (e) {
      print('Error fetching bill info: $e');
      return []; // Return an empty list or handle the error accordingly
    }
  }

  void filterBills(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredBills = List.from(bills);
      } else {
        filteredBills = bills
            .where((bill) =>
        bill.billNum.toString().contains(searchText) ||
            (bill.buyer != null && bill.buyer!.toLowerCase().contains(searchText.toLowerCase())))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Purchases'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                  Navigator.pushNamed(context, '/addbill');
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add New Bill'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Search',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          filterBills(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search by Bill Number or Buyer',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        searchController.clear();
                        filterBills('');
                      },
                      icon: Icon(Icons.close),
                      label: Text('Clear'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: filteredBills.length,
                itemBuilder: (BuildContext context, int index) {
                  final bill = filteredBills[index];
                  return GestureDetector(
                    onTap: () async {
                      List<BillInfoResponseModel> billInfoList = await fetchBillInfo(bill.billNum ?? -1);
                      if (billInfoList.isNotEmpty) {
                        BillInfoResponseModel billInfo = billInfoList[0];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillInfo(billInfoList: billInfoList, billInfo: billInfo),
                          ),
                        );
                      } else {
                        // Handle the case where billInfoList is empty or not fetched successfully
                        // Show an error message or handle it appropriately
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Failed to load bill information.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },

                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Number of Bill: ${bill.billNum ?? 'N/A'}',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              '${bill.date ?? 'N/A'}', // Format date as needed
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'From: ${bill.buyer ?? 'N/A'}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 5.0),
                          ],
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
    );
  }
}