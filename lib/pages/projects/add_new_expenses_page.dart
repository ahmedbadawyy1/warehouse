import 'package:flutter/material.dart';

import '../../services/apiservices.dart';

class AddNewExpenses extends StatefulWidget {
  final int projectId;

  const AddNewExpenses({Key? key, required this.projectId}) : super(key: key);

  @override
  State<AddNewExpenses> createState() => _AddNewExpensesState();
}

class _AddNewExpensesState extends State<AddNewExpenses> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController engNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Expenses'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: itemNameController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: costController,
              decoration: InputDecoration(labelText: 'Cost'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: engNameController,
              decoration: InputDecoration(labelText: 'Eng Name'),
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call function to save expenses
                _saveExpenses();
              },
              child: Text('Save Expenses'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveExpenses() {
    String itemName = itemNameController.text;
    double cost = double.tryParse(costController.text) ?? 0.0;
    String date = dateController.text;
    String engName = engNameController.text;

    Map<String, dynamic> expenseData = {
      'project_id': widget.projectId,
      'expenses': [
        {
          'item': itemName,
          'cost': cost,
          'date': date,
          'eng_name': engName,
        },
      ],
    };

    APIService().postExpenseData(expenseData).then((response) {
      // Handle the API response here
      // For example, show a success message or navigate back on success
    }).catchError((error) {
      // Handle errors here
    });
  }

  @override
  void dispose() {
    itemNameController.dispose();
    costController.dispose();
    dateController.dispose();
    engNameController.dispose();
    super.dispose();
  }
}
