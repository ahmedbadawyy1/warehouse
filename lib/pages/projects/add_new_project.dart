import 'package:flutter/material.dart';
import 'package:warehousse33/models/projects/add_new_project_request_model.dart';


import '../../services/apiservices.dart';

class AddNewProject extends StatefulWidget {
  const AddNewProject({Key? key}) : super(key: key);

  @override
  State<AddNewProject> createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
  DateTime selectedDate = DateTime.now();
  TextEditingController projectNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController projectCapitalController = TextEditingController();
  TextEditingController engineerNameController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        startDateController.text = pickedDate.toString().split(' ')[0];
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Project'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: projectNameController,
                decoration: InputDecoration(
                  labelText: 'Project Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a project name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: startDateController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Date',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: placeController,
                decoration: InputDecoration(
                  labelText: 'Place',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Place';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: companyController,
                decoration: InputDecoration(
                  labelText: 'Company',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Company';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: projectCapitalController,
                decoration: InputDecoration(
                  labelText: 'Project Capital',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Project Capital';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: engineerNameController,
                decoration: InputDecoration(
                  labelText: 'Project Engineer Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Project Engineer Name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0),
              Center(
                child: SizedBox(
                  width: 150.0,
                  height: 50.0,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _saveProject(context);
                    },
                    icon: Icon(Icons.save),
                    label: Text('Save Project'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProject(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String projectName = projectNameController.text;
      String startDate = startDateController.text;
      String place = placeController.text;
      String company = companyController.text;
      int projectCapital = int.tryParse(projectCapitalController.text) ?? 0;
      String engineerName = engineerNameController.text;

      AddNewProjectRequestModel newProject = AddNewProjectRequestModel(
        nameOfProject: projectName,
        date: startDate,
        engName: engineerName,
        place: place,
        company: company,
        total: projectCapital,
      );

      APIService apiServices = APIService();

      apiServices.postProjectData(newProject).then((response) {
        print('Project added successfully: ${response.message}');
        _showSnackBar(context, 'Project added successfully');
      }).catchError((error) {
        print('Error adding project: $error');
        _showSnackBar(context, 'Failed to add project');
      });
    }
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
