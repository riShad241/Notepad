import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotepadView extends StatefulWidget {
  final String title;
  final String description;
  final String time;
  final String documentId;

  const NotepadView({Key? key,
    required this.title,
    required this.description,
    required this.time,
    required this.documentId})
      : super(key: key);

  @override
  State<NotepadView> createState() => _NotepadViewState();
}

class _NotepadViewState extends State<NotepadView> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.description);
    _stream = FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser?.email)
        .collection('task')
        .doc(widget.documentId)
        .snapshots();
    super.initState();
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  Future<void> edit() async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser?.email)
        .collection('task')
        .doc(widget.documentId).update({
      'title': titleController.text.trim(),
      'description': descriptionController.text.trim(),
      'created_at': FieldValue.serverTimestamp()
    }
      ,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: StreamBuilder<DocumentSnapshot>(
            stream: _stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error');
              }
              if (!snapshot.hasData) {
                return const Text('Loading...');
              }

              var data = snapshot.data!.data() as Map<String, dynamic>;
              titleController.text = data['title'] ?? '';
              descriptionController.text = data['description'] ?? '';

              return Text(
                titleController.text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              );
            }
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Edit Your Task'),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: titleController,
                                    maxLines: 1,
                                    decoration:const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: descriptionController,
                                    maxLines: 8,
                                    decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(onPressed: (){
                              edit();
                              Navigator.pop(context);
                            }, child: Text('Confirm')),
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text('Close')),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.edit,
                  size: 30,
                )),
          ],
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error');
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;
            var created_at = data['created_at'];
            DateTime dateTime;
            if (created_at != null && created_at is Timestamp) {
              dateTime = created_at.toDate();
            } else {
              dateTime = DateTime.now();
            }
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child:SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Time: ${DateFormat('hh:mm a, dd-MM-yyyy').format(dateTime)}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            descriptionController.text,
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ],
                    )
                )
            );
          }
        ));
  }
}