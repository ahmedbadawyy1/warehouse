import 'package:flutter/material.dart';

import '../../models/warehouse_models/add_new_item_request_model.dart';
import '../../services/apiservices.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({Key? key}) : super(key: key);

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  TextEditingController productIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController productNumController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController serialController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController buyerController = TextEditingController();
  TextEditingController receiverController = TextEditingController();

  Widget _buildTwoBorderedTextFields(String labelText1, String labelText2, TextEditingController controller1, TextEditingController controller2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller1,
                decoration: InputDecoration(
                  labelText: labelText1,
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue), // Change focused border color here
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller2,
                decoration: InputDecoration(
                  labelText: labelText2,
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue), // Change focused border color here
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              _buildTwoBorderedTextFields('Product ID', 'Name', productIdController, nameController),
              _buildTwoBorderedTextFields('Price', 'Category', priceController, categoryController),
              _buildTwoBorderedTextFields('Source', 'Product Number', sourceController, productNumController),
              _buildTwoBorderedTextFields('Date', 'Model', dateController, modelController),
              _buildTwoBorderedTextFields('Serial', 'Quantity', serialController, quantityController),
              _buildTwoBorderedTextFields('Buyer', 'Receiver', buyerController, receiverController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call a function to save the item using the entered data
                  _saveItem(context);
                },
                child: Text('Save Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveItem(BuildContext context) {
    // Get the values from text fields
    int productId = int.tryParse(productIdController.text) ?? 0;
    String name = nameController.text;
    double price = double.tryParse(priceController.text) ?? 0.0;
    String category = categoryController.text;
    String source = sourceController.text;
    String productNum = productNumController.text;
    String date = dateController.text;
    String model = modelController.text;
    String serial = serialController.text;
    int quantity = int.tryParse(quantityController.text) ?? 0;
    String buyer = buyerController.text;
    String receiver = receiverController.text;

    // Create an instance of the request model with the entered data
    AddNewItemRequestModel newItem = AddNewItemRequestModel(
      productId: productId,
      name: name,
      price: price,
      category: category,
      source: source,
      productNum: productNum,
      date: date,
      model: model,
      serial: serial,
      quantity: quantity,
      buyer: buyer,
      receiver: receiver,
    );

    // Instantiate the API services class
    APIService apiServices = APIService();

    apiServices.postNewItemData(newItem)
        .then((response) {
      print('Item saved successfully: ${response.message}');
      _showSnackBar(context, 'Item saved successfully');
    })
        .catchError((error) {
      print('Error saving item: $error');
      _showSnackBar(context, 'Failed to save item');
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
