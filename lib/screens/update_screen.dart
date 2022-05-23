import 'package:dog_management/models/dog_model.dart';
import 'package:dog_management/services/db_service.dart';
import 'package:dog_management/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:dog_management/screens/display_screen.dart';
import 'package:dog_management/main.dart';

class UpdateScreen extends StatefulWidget {
  Dog dog;
  VoidCallback reload;
  UpdateScreen({
    Key? key,
    required this.reload,
    required this.dog,
  }) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  List<Dog> updDog = [];

  @override
  void initState() {
    // print(widget.dog.name);
    // print(widget.dog.age);
    nameController.text = widget.dog.name;
    ageController.text = '${widget.dog.age}';
    super.initState();
  }

  updateDog() {
    Dog data = Dog(
        name: nameController.text,
        age: int.parse(ageController.text),
        id: widget.dog.id);
    DBHelper.db.updateDog(data, widget.dog.id);
    setState(() {
      DBHelper.db.retriveDog().then((newUpdate) {
        setState(() {
          updDog = newUpdate;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.red, Colors.blue],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(60),
                    right: Radius.circular(0),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blueAccent, Colors.red],
                  ),
                ),
                height: 280,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),

                  // padding: const EdgeInsets.all(8.0),
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
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              updateDog();
                            });
                            widget.reload();
                            Navigator.of(context).pop();

                            // Navigator.of(context).pushReplacement(
                            //   MaterialPageRoute(
                            //       builder: (context) => DisplayScreen()),
                            // );
                          },
                          child: const Text('Update'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
