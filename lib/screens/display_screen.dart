// import 'package:dog_management/screens/update_screen.dart';
import 'package:dog_management/screens/home_page.dart';
import 'package:dog_management/services/db_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dog_management/screens/update_screen.dart';

import '../models/dog_model.dart';

class DisplayScreen extends StatefulWidget {
//  final String upNam;
//   final int upAg;
  const DisplayScreen({
    Key? key,
  }) : super(key: key);

  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  List<Dog> dogList = [];

  @override
  void initState() {
    DBHelper.db.retriveDog().then((value) {
      setState(() {
        dogList = value;
      });
    });
    super.initState();
  }

  void removeDog(int? dogId) {
    DBHelper.db.deleteDog(dogId);

    DBHelper.db.retriveDog().then((value) {
      setState(() {
        dogList = value;
      });
    });
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
        body: dogList.isEmpty
            ? const Center(
                child: Text('No data available!!!'),
              )
            : SafeArea(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: dogList.length,
                    itemBuilder: ((context, index) {
                      var dog = dogList[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.green, Colors.amber]),
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(10),
                            left: Radius.circular(10),
                          ),
                        ),
                        child: Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),

                          // elevation: 6,

                          // margin: const EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(dogList[index].name.toUpperCase()),
                            subtitle:
                                Text('Age: ${dogList[index].age.toString()}'),
                            leading: CircleAvatar(
                              child: Text(
                                dogList[index].id.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.pink,
                            ),
                            trailing: SizedBox(
                              // color: Colors.black,
                              width: 100,
                              height: 50,
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.indigo,
                                    ),
                                    onPressed: () {
                                      // print(dog);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UpdateScreen(
                                              dog: dog,
                                              reload: () {
                                                DBHelper.db
                                                    .retriveDog()
                                                    .then((value) {
                                                  setState(() {
                                                    dogList = value;
                                                  });
                                                });
                                              },
                                            ),
                                          ));
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        removeDog(dogList[index].id);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
              ),
      ),
    );
  }
}
