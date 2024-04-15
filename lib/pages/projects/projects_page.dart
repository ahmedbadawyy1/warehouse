import 'package:flutter/material.dart';
import 'package:warehousse33/models/projects/project_detials_response_model.dart';
import 'package:warehousse33/models/projects/projects_response_model.dart';
import 'package:warehousse33/services/apiservices.dart';
import 'project_details_page.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  List<ProjectsResponseModel> projectList = [];
  List<ProjectsResponseModel> filteredProjects = [];
  TextEditingController _searchController = TextEditingController();

  void navigateToProjectDetails(int? projectId) async {
    if (projectId != null) {
      try {
        final apiService = APIService();
        ProjectDetailsResponseModel projectDetails =
        await apiService.fetchProjectDetails(projectId);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetails(
              projectId: projectId,
              projectDetails: projectDetails,
            ),
          ),
        );
      } catch (e) {
        print('Error fetching project details: $e');
      }
    } else {
      print('Project ID is null!');
      // Handle the scenario where the project ID is null
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final apiService = APIService();
      List<ProjectsResponseModel> projects = await apiService.fetchProjects();
      setState(() {
        projectList = projects;
        filteredProjects = projects;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void filterProjects(String query) {
    setState(() {
      filteredProjects = projectList
          .where((project) =>
      project.nameOfProject!
          .toLowerCase()
          .contains(query.toLowerCase()) ||
          project.engineerName!
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/addnewproject');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Project'),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search By Project Name Or Engineer Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      filterProjects(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProjects.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text('Project ID: ${filteredProjects[index].id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Project Name: ${filteredProjects[index].nameOfProject}'),
                          Text(
                              'Date: ${filteredProjects[index].date.toString()}'),
                          Text(
                              'Engineer Name: ${filteredProjects[index].engineerName}'),
                        ],
                      ),
                      onTap: () {
                        navigateToProjectDetails(filteredProjects[index].id);
                      },
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
