// import 'package:flutter/material.dart';
// import 'package:warehousse33/models/projects/project_detials_response_model.dart';
//
//
// class ProjectDetails extends StatefulWidget {
//   final int projectId;
//   final ProjectDetailsResponseModel projectDetails;
//
//   const ProjectDetails({
//     Key? key,
//     required this.projectId,
//     required this.projectDetails,
//   }) : super(key: key);
//
//   @override
//   State<ProjectDetails> createState() => _ProjectDetailsState();
// }
//
// class _ProjectDetailsState extends State<ProjectDetails> {
//   late Future<ProjectDetailsResponseModel> _futureProjectDetails;
//
//   @override
//   void initState() {
//     super.initState();
//     _futureProjectDetails = Future.value(widget.projectDetails);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Project Details'),
//       ),
//       body: FutureBuilder<ProjectDetailsResponseModel>(
//       future: _futureProjectDetails,
//       builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             ProjectDetailsResponseModel projectDetails = snapshot.data!;
//             return buildProjectDetailsUI(projectDetails);
//           } else {
//             return Center(child: Text('No data available'));
//           }
//         },
//       ),
//     );
//   }
//
//   Widget buildProjectDetailsUI(ProjectDetailsResponseModel projectDetails) {
//     Project project = projectDetails.projectDetails.first; // Assuming only one project is retrieved
//
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Project ID: ${project.projectId}',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Text('Date: ${project.date.toString()}'),
//           SizedBox(height: 8),
//           Text('Place: ${project.place}'),
//           SizedBox(height: 8),
//           Text('Company: ${project.company}'),
//           SizedBox(height: 8),
//           Text('Total: ${project.total.toString()}'),
//           SizedBox(height: 8),
//           Text('Engineer Name: ${project.engName}'),
//           SizedBox(height: 16),
//           Text(
//             'Expenses:',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Expanded(
//             child: ListView.builder(
//               itemCount: project.expenses.length,
//               itemBuilder: (context, index) {
//                 Expense expense = project.expenses[index];
//                 return ListTile(
//                   title: Text(expense.item),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Cost: ${expense.cost.toString()}'),
//                       Text('Expense Date: ${expense.expenseDate.toString()}'),
//                       Text('Expense Eng Name: ${expense.expenseEngName.toString()}'),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:warehousse33/models/projects/project_detials_response_model.dart';
import 'package:warehousse33/pages/projects/add_new_expenses_page.dart';
import '../../models/projects/profitloss_response_model.dart';
import '../../services/apiservices.dart';

class ProjectDetails extends StatefulWidget {
  final int projectId;
  final ProjectDetailsResponseModel projectDetails;

  const ProjectDetails({
    Key? key,
    required this.projectId,
    required this.projectDetails,
  }) : super(key: key);

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  late Future<ProjectDetailsResponseModel> _futureProjectDetails;
  late Future<ProfitLossResponseModel> _futureProfitLoss;

  @override
  void initState() {
    super.initState();
    _futureProjectDetails = APIService().fetchProjectDetails(widget.projectId);
    _futureProfitLoss =
        APIService().fetchProfitLossForProject(widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.add), // Use your desired icon here
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNewExpenses(projectId: widget.projectId),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Future.wait([_futureProjectDetails, _futureProfitLoss]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          ProjectDetailsResponseModel projectDetails =
          snapshot.data![0] as ProjectDetailsResponseModel;
          ProfitLossResponseModel profitLoss =
          snapshot.data![1] as ProfitLossResponseModel;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildProjectDetailsUI(projectDetails),
                  buildProfitLossUI(profitLoss),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildProjectDetailsUI(ProjectDetailsResponseModel projectDetails) {
    Project project = projectDetails.projectDetails.first;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Project ID: ${project.projectId}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Date: ${project.date.toString()}'),
          SizedBox(height: 8),
          Text('Place: ${project.place}'),
          SizedBox(height: 8),
          Text('Company: ${project.company}'),
          SizedBox(height: 8),
          Text('Total: ${project.total.toString()}'),
          SizedBox(height: 8),
          Text('Engineer Name: ${project.engName}'),
          SizedBox(height: 16),
          Text(
            'Expenses:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: project.expenses.length,
            itemBuilder: (context, index) {
              Expense expense = project.expenses[index];
              return ListTile(
                title: Text(expense.item),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cost: ${expense.cost.toString()}'),
                    Text('Expense Date: ${expense.expenseDate.toString()}'),
                    Text('Expense Eng Name: ${expense.expenseEngName.toString()}'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildProfitLossUI(ProfitLossResponseModel profitLoss) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profit/Loss Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Total Revenue: ${profitLoss.totalRevenue.toString()}'),
          SizedBox(height: 8),
          Text('Total Expenses: ${profitLoss.totalExpenses.toString()}'),
          SizedBox(height: 8),
          Text('Profit/Loss: ${profitLoss.profitLoss.toString()}'),
          // Add more UI elements or styling as needed
        ],
      ),
    );
  }
}
