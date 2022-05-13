import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/student.dart';
import 'package:flutter_application_1/screens/student.add.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State {
  List<Student> studets = [
    Student.withId(1, "Ali", "Terliksiz", 88),
    Student.withId(2, "Berkay", "Bilgin", 45),
    Student.withId(3, "Kerem", "Varış", 25)
  ];

  Student selectedStudent = Student.withId(0, "Hiç kimse", "", 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Öğrenci takip sistemi"),
        ),
        body: buildBody());
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: studets.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                      studets[index].firstName + " " + studets[index].lastName),
                  subtitle: Text("Sınavdan aldığı not: " +
                      studets[index].grade.toString() +
                      " " +
                      "[" +
                      studets[index].getStatus +
                      "]"),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/194/194931.png"),
                  ),
                  trailing: builStatusIcon(studets[index].grade),
                  onTap: () {
                    setState(() {
                      this.selectedStudent = studets[index];
                    });
                    print(this.selectedStudent.firstName);
                  },
                  onLongPress: () {
                    print("Uzun basıldı");
                  },
                );
              }),
        ),
        Text("Seçili öğrenci " + selectedStudent.firstName),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.greenAccent,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Yeni öğrenci")
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentAdd(studets)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.black12,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Guncelle")
                  ],
                ),
                onPressed: () {
                  print("Guncelle");
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.amberAccent,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Sil")
                  ],
                ),
                onPressed: () {
                  print("Sil");
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Widget builStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade > 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }
}
