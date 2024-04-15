import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:warehousse33/models/warehouse_models/bill_selling_request_model.dart';
import '../models/projects/profitloss_response_model.dart';
import '../models/warehouse_models/add_new_item_request_model.dart';
import '../models/warehouse_models/add_new_item_response_model.dart';
import '../models/warehouse_models/bill_info_purchases_response_model.dart';
import '../models/warehouse_models/bill_info_selling_response_model.dart';
import '../models/warehouse_models/bill_page_request_purchases_model.dart';
import '../models/warehouse_models/bill_page_response_purchases_model.dart';
import '../models/warehouse_models/bill_selling_resonse_model.dart';
import '../models/projects/add_new_project_request_model.dart';
import '../models/projects/add_new_project_response_model.dart';
import '../models/projects/project_detials_response_model.dart';
import '../models/projects/projects_response_model.dart';
import '../models/warehouse_models/purchases_response_model.dart';
import '../models/warehouse_models/selling_response_model.dart';
import '../models/warehouse_models/store_page_response_model.dart';



String apilink = "localhost" ;


class APIService {

  Future<List<StorePageResponseModel>> fetchGoods() async {
    final apiUrl = 'http://${apilink}:3000/api/goods'; // Replace this with your API URL

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print("ok");
        // If the call to the server was successful, parse the JSON
        List<dynamic> jsonData = json.decode(response.body);

        // Mapping JSON data to StorePageResponseModel list
        List<StorePageResponseModel> goodsList = jsonData
            .map((item) => StorePageResponseModel.fromJson(item))
            .toList();

        return goodsList;
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception with the status code and reason
        throw Exception('Failed to load goods: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any error that might have occurred during the process
      throw Exception('Failed to load goods: $e');
    }
  }

  Future<BillResponseModel> postBillData(Root billData) async {
    final apiUrl = 'http://${apilink}:3000/api/buys';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(billData.toJson()),
      );

      if (response.statusCode == 201) {
        print("ok");
        return BillResponseModel.fromJson(json.decode(response.body));
      } else {
        print("Unexpected status code: ${response.statusCode}");
        throw Exception('Failed to post bill data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Exception occurred while posting bill data: $e");
      throw Exception('Failed to post bill data: $e');
    }
  }

  Future<List<PurchasesResponseModel>> fetchBills() async {
    final String apiUrl = 'http://${apilink}:3000/api/all-buys'; // Replace with the endpoint for fetching bills

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        List<dynamic> jsonData = json.decode(response.body);

        // Mapping JSON data to PurchasesResponseModel list
        List<PurchasesResponseModel> billsList = jsonData
            .map((item) => PurchasesResponseModel.fromJson(item))
            .toList();

        return billsList;
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception with the status code and reason
        throw Exception('Failed to load bills: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any error that might have occurred during the process
      throw Exception('Failed to load bills: $e');
    }
  }
  Future<List<BillInfoResponseModel>> fetchBillInfo(int billNum) async {
    final apiUrl = 'http://${apilink}:3000/api/items-by-bill/$billNum';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse JSON response
        dynamic jsonData = json.decode(response.body);

        // Check if jsonData is a list or a map
        if (jsonData is List) {
          // It's a list, so proceed with mapping
          List<BillInfoResponseModel> billInfoList = jsonData
              .map((jsonItem) => BillInfoResponseModel.fromJson(jsonItem))
              .toList();

          return billInfoList;
        } else if (jsonData is Map<String, dynamic>) {
          // If it's a map, extract the list from it
          List<dynamic>? itemList = jsonData['items'];

          if (itemList != null && itemList is List) {
            List<BillInfoResponseModel> billInfoList = itemList
                .map((jsonItem) => BillInfoResponseModel.fromJson(jsonItem))
                .toList();

            return billInfoList;
          } else {
            throw Exception('Invalid or missing "items" list in JSON');
          }
        } else {
          throw Exception('Invalid data format received');
        }
      } else {
        throw Exception('Failed to load bill info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load bill info: $e');
    }
  }


  Future<BillSellingResponseModel> postBillSellingData(RootSelling billData) async {
    final apiUrl = 'http://${apilink}:3000/api/sells';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(billData.toJson()),
      );

      if (response.statusCode == 201) {
        print("ok");
        return BillSellingResponseModel.fromJson(json.decode(response.body));
      } else {
        print("Unexpected status code: ${response.statusCode}");
        throw Exception('Failed to post bill data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Exception occurred while posting bill data: $e");
      throw Exception('Failed to post bill data: $e');
    }
  }

  Future<List<SellingResponseModel>> fetchBillsSelling() async {
    final String apiUrl = 'http://${apilink}:3000/api/all-sells'; // Replace with the endpoint for fetching bills

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        List<dynamic> jsonData = json.decode(response.body);

        // Mapping JSON data to PurchasesResponseModel list
        List<SellingResponseModel> billsList = jsonData
            .map((item) => SellingResponseModel.fromJson(item))
            .toList();

        return billsList;
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception with the status code and reason
        throw Exception('Failed to load bills: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any error that might have occurred during the process
      throw Exception('Failed to load bills: $e');
    }
  }
  Future<List<BillInfoSellingResponseModel>> fetchBillInfoSElling(int billNum) async {
    final apiUrl = 'http://${apilink}:3000/api/items-by-bill-sell/$billNum';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse JSON response
        dynamic jsonData = json.decode(response.body);

        // Check if jsonData is a list or a map
        if (jsonData is List) {
          // It's a list, so proceed with mapping
          List<BillInfoSellingResponseModel> billInfoList = jsonData
              .map((jsonItem) => BillInfoSellingResponseModel.fromJson(jsonItem))
              .toList();

          return billInfoList;
        } else if (jsonData is Map<String, dynamic>) {
          // If it's a map, extract the list from it
          List<dynamic>? itemList = jsonData['items'];

          if (itemList != null && itemList is List) {
            List<BillInfoSellingResponseModel> billInfoList = itemList
                .map((jsonItem) => BillInfoSellingResponseModel.fromJson(jsonItem))
                .toList();

            return billInfoList;
          } else {
            throw Exception('Invalid or missing "items" list in JSON');
          }
        } else {
          throw Exception('Invalid data format received');
        }
      } else {
        throw Exception('Failed to load bill info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load bill info: $e');
    }
  }


  Future<AddNewItemResponseModel> postNewItemData(AddNewItemRequestModel billData) async {
    final apiUrl = 'http://${apilink}:3000/api/add-items';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(billData.toJson()),
      );

      if (response.statusCode == 201) {
        print("ok");
        return AddNewItemResponseModel.fromJson(json.decode(response.body));
      } else {
        print("Unexpected status code: ${response.statusCode}");
        throw Exception('Failed to post new item data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Exception occurred while posting new item: $e");
      throw Exception('Failed to post new item: $e');
    }
  }

  Future<List<ProjectsResponseModel>> fetchProjects() async {
    final String apiUrl = 'http://${apilink}:3000/api/projects'; // Your API endpoint for fetching projects

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);

        // Mapping JSON data to ProjectsResponseModel list
        List<ProjectsResponseModel> projectsList = jsonData
            .map((item) => ProjectsResponseModel.fromJson(item))
            .toList();

        return projectsList;
      } else {
        throw Exception('Failed to load projects: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load projects: $e');
    }
  }

  Future<AddNewProjectResponseModel> postProjectData(AddNewProjectRequestModel projectData) async {
    final apiUrl = 'http://${apilink}:3000/api/add-project';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(projectData.toJson()), // Convert projectData to JSON
      );

      if (response.statusCode == 201) {
        print("ok");
        return AddNewProjectResponseModel.fromJson(json.decode(response.body));
      } else {
        print("Unexpected status code: ${response.statusCode}");
        throw Exception('Failed to post project data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Exception occurred while posting project data: $e");
      throw Exception('Failed to post project data: $e');
    }
  }

  Future<ProjectDetailsResponseModel> fetchProjectDetails(int projectId) async {
    final String apiUrl = 'http://${apilink}:3000/api/project-details-with-expenses/$projectId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return ProjectDetailsResponseModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load project details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load project details: $e');
    }
  }


  Future<ProfitLossResponseModel> fetchProfitLossForProject(int projectId) async {
    final String apiUrl = 'http://${apilink}:3000/api/project/$projectId/profit-loss';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return ProfitLossResponseModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load profit/loss details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load profit/loss details: $e');
    }
  }

  Future<void> postExpenseData(Map<String, dynamic> expenseData) async {
    final String apiUrl = 'http://${apilink}:3000/api/expense'; // Replace with your expense API endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(expenseData),
      );

      if (response.statusCode == 201) {
        print('Expense data posted successfully.');
        // Handle success as needed
      } else {
        throw Exception('Failed to post expense data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to post expense data: $e');
    }
  }
}








