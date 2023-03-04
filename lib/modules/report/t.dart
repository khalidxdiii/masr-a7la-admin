import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Example'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                searchTerm = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search',
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('problems').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                List<problems> report = documents
                    .map((doc) => problems.fromDocumentSnapshot(doc))
                    .toList();

                return ListView.builder(
                  itemCount: report.length,
                  itemBuilder: (context, index) {
                    if (searchTerm.isEmpty ||
                        report[index].id.toLowerCase().contains(searchTerm)) {
                      return ListTile(
                        title: Text(report[index].name),
                        subtitle: Text(report[index].description),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class problems {
  final String id;
  final String name;
  final String description;

  problems({
    required this.id,
    required this.name,
    required this.description,
  });

  factory problems.fromDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return problems(
      id: snapshot.id,
      name: data['title_disc'],
      description: data['problem_disc'],
    );
  }
}
