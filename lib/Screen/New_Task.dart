import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  Future<void> NewTask() async{
    try{
      String email = FirebaseAuth.instance.currentUser?.email ?? '';
       CollectionReference<Map<String, dynamic>> userRef =
           FirebaseFirestore.instance.collection('User').doc(email).collection('task');
       await userRef.add({
         'title': _titleController.text.trim(),
         'description': _descriptionController.text.trim(),
         'created_at': FieldValue.serverTimestamp(),
       });
       _titleController.clear();
       _descriptionController.clear();
       
       
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task added successfully')));

    }catch(err0r){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add task')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Add Task'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Add a New task',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _titleController,
                decoration:const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
              child: TextFormField(
                controller: _descriptionController,
                maxLines: 8,
                decoration:const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none
                  )
                ),
              ),
            ),

            const SizedBox(height: 20,),
            SizedBox(
                height: 60,
                width: 180,
                child: ElevatedButton(onPressed: (){

                  NewTask();
                }, child: Icon(Icons.add))),
          ],
        ),
      ),
    );
  }
}
