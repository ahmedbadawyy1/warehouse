import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:warehousse33/pages/warehouse/add_bill_purchases_page.dart';
import 'package:warehousse33/pages/warehouse/add_bill_selling_page.dart';
import 'package:warehousse33/pages/warehouse/add_new_item_page.dart';
import 'package:warehousse33/pages/warehouse/bill_info_purchases.dart';
import 'package:warehousse33/pages/main_page.dart';
import 'package:warehousse33/pages/projects/add_new_project.dart';
import 'package:warehousse33/pages/projects/manage_projects.dart';
import 'package:warehousse33/pages/projects/projects_page.dart';
import 'package:warehousse33/pages/warehouse/selling_page.dart';
import 'pages/warehouse/home.dart';
import 'pages/warehouse/purchases_page.dart';
import 'pages/warehouse/store_page.dart';
import 'models/projects/project_detials_response_model.dart';
import 'pages/projects/project_details_page.dart';

void main() {
//  debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const MainPage(),
        '/home': (context) => const Home(),
        '/store_page': (context) => const StorePage(),
        '/purchases_page': (context) => const PurchasesPage(),
        '/addbill': (context) => const AddBill(),
        '/BillInfo': (context) => BillInfo(billInfo: null, billInfoList: null,),
        '/sellingpage': (context) => const SellingPage(),
        '/addselling': (context) => const AddBillSelling(),
        '/addnewitem': (context) => const AddNewItem(),
        '/manageprojects': (context) => const ManageProjects(),
        '/projects': (context) => const Projects(),
        '/addnewproject': (context) => const AddNewProject(),
        '/projectdetails': (context) {
          final Map<String, dynamic>? args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

          if (args != null) {
            final int? projectId = args['projectId'] as int?;
            final ProjectDetailsResponseModel? projectDetails = args['projectDetails'] as ProjectDetailsResponseModel?;

            if (projectId != null && projectDetails != null) {
              return ProjectDetails(projectId: projectId, projectDetails: projectDetails);
            }
          }

          return Scaffold(
            body: Center(
              child: Text('Error: Missing projectId or projectDetails'),
            ),
          );
        },
      //  '/addnewexpenses': (context) =>  AddNewExpenses(projectId: null,),


      },
    );
  }
}