import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:notepad/Screen/Notepad_view.dart';
import 'package:notepad/widget/empty_view.dart';
import 'package:intl/intl.dart';

import 'New_Task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isList = true;
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<void> deletTask(String taskid) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser?.email)
        .collection('task')
        .doc(taskid)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 3;
    double itemHeight = 180.0;
    double itemWidth = MediaQuery.of(context).size.width / crossAxisCount;
    double aspectRatio = itemWidth / itemHeight;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Pad'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _isList = !_isList;
                });
              },
              icon: Icon(
                _isList ? Icons.list : Icons.grid_view_outlined,
                size: 30,
              )),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser?.email)
            .collection('task')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                EmptyView(),
              ],
            );
          }
          return _isList
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];

                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    var created_at = data['created_at'];
                    DateTime dateTime;
                    if (created_at != null && created_at is Timestamp) {
                      dateTime = created_at.toDate();
                    } else {
                      dateTime = DateTime.now();
                    }
                    return InkWell(
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Delete Task'),
                                content:
                                    Text('Are you sure you delete this task'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        deletTask(document.id);
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('close')),
                                ],
                              );
                            });
                      },
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotepadView(
                                      description: data['description'],
                                      title: data['title'],
                                      time: DateFormat('hh:mm a, dd-MM-yyyy')
                                          .format(dateTime), documentId: document.id,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: ListTile(
                            title: Text(
                              data['title'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              data['description'],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(
                                'Time: ${DateFormat('hh:mm a, dd-MM-yyyy').format(dateTime)}'),
                            // Add other task details as needed
                          ),
                        ),
                      ),
                    );
                  },
                )
              : SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: aspectRatio,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      var created_at = data['created_at'];
                      DateTime dateTime;
                      if (created_at != null && created_at is Timestamp) {
                        dateTime = created_at.toDate();
                      } else {
                        dateTime = DateTime.now();
                      }
                      return InkWell(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete Task'),
                                  content:
                                  Text('Are you sure you delete this task'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          deletTask(document.id);
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('close')),
                                  ],
                                );
                              });
                        },
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotepadView(
                                    description: data['description'],
                                    title: data['title'],
                                    time: DateFormat('hh:mm a, dd-MM-yyyy')
                                        .format(dateTime), documentId: document.id,
                                  )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 110,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      )
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 10, top: 5),
                                  child: Text(
                                    data['description'],
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      data['title'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Time: ${DateFormat('hh:mm a, dd-MM-yyyy').format(dateTime)}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewTask()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
