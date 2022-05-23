import 'package:dog_management/models/dog_model.dart';
import 'package:dog_management/services/db_service.dart';
import 'package:flutter/material.dart';

import '../widgets/textfield_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  void addTo() async {
    if (nameController.text.isEmpty || ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please insert the given fields'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
        elevation: 5,
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      Dog dogObj = Dog(
        name: nameController.text,
        age: int.parse(ageController.text),
      );
      await DBHelper.db.insertDog(dogObj);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Added successfully'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
        elevation: 5,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.red, Colors.blue],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: const Text('Dog Management System'),
        // ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextfieldWidget(
                controllerValue: nameController,
                lblText: 'Dog\'s name',
                inType: TextInputType.text,
              ),
              const SizedBox(
                height: 15,
              ),
              TextfieldWidget(
                controllerValue: ageController,
                lblText: 'Dog\'s age',
                inType: TextInputType.number,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                child: Divider(
                  color: Colors.black,
                  height: 5,
                  thickness: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      addTo();
                    },
                    child: const Text('Send'),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  edit() {}
}
