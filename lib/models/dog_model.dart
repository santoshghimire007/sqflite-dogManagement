class Dog {
  int? id;
  String name;
  int age;
  Dog({required this.name, required this.age, this.id});

//this map function is use to insert in database
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

//this is for
  Dog.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        age = res['age'];
}
