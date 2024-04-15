import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Add your centered title
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            'WareHouse',
            style: TextStyle(
              color: Colors.white,
            ),),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Add your image logo
              Image.asset(
                'images/Picture1.jpg', // Replace with your image asset path
                width:
                350, // Set width as per your requirement
              ),
              SizedBox(height: 100), // Adjust spacing as needed
              // Add your buttons
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.all(16.0), // Adjust padding as needed
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Add border for a box-like appearance
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // Add your buttons
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Navigate to 'Enter Goods' page
                            Navigator.pushNamed(context, '/addnewitem');
                          },
                          icon: Icon(Icons.add), // Add icon before text
                          label: Text('اضف كود', style: TextStyle(fontSize: 18.0)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlueAccent, // Change button color as needed
                            minimumSize: Size(double.infinity, 80),// Set button height
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Navigate to 'Enter Goods' page
                            Navigator.pushNamed(context, '/purchases_page');
                          },
                          icon: Icon(Icons.input), // Add icon before text
                          label: Text('المشتريات', style: TextStyle(fontSize: 18.0)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightGreen, // Change button color as needed
                            minimumSize: Size(double.infinity, 80),// Set button height
                          ),
                        ),
                      ),
                      SizedBox(width: 20), // Adjust spacing between buttons
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Navigate to 'Enter Goods' page
                            Navigator.pushNamed(context, '/sellingpage');
                          },
                          icon: Icon(Icons.output), // Add icon before text
                          label: Text('المبيعات', style: TextStyle(fontSize: 18.0)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red, // Change button color as needed
                            minimumSize: Size(double.infinity, 80),// Set button height
                          ),
                        ),
                      ),
                      SizedBox(width: 20), // Adjust spacing between buttons
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Navigate to 'Enter Goods' page
                            Navigator.pushNamed(context, '/store_page');
                          },
                          icon: Icon(Icons.all_inbox), // Add icon before text
                          label: Text('المخزن', style: TextStyle(fontSize: 18.0)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey, // Change button color as needed
                            minimumSize: Size(double.infinity, 80),// Set button height
                          ),
                        ),
                      ),
                    ],
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
