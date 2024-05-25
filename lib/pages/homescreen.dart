import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Driver/services/firestore.dart';
import 'package:get/get.dart';
import 'package:Driver/config/colors.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();

  void openBox({String? docId}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(docId == null ? '' : 'Update state'),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            labelText: 'Confirm',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text != null &&
                  textController.text.isNotEmpty) {
                if (docId == null) {
                  firestoreService.addNote(textController.text);
                } else {
                  firestoreService.updateNote(docId, textController.text);
                }
                textController.clear();
                Navigator.pop(context);
              } else {
                // Show an error message or take appropriate action
              }
            },
            child: Text(docId == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/Capture.PNG",
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 20),
            const Text(
              "Mange order",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                // parkingController.timeCounter();
                //Get.toNamed("/about-us");
              
                      Get.offAllNamed('/about-us'); 


              },
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              )),
        ],
        centerTitle: true,
      ),
      body: 
    
      
        StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = notesList[index];
                String docId = document.id ?? "";

                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic> ?? {};
                String noteText = "user name: "+data['name']+"\n"+"car plate: "+data['car_plate']+"\n"+"date :"+data['data']+"\n"+"Total :"+data['paytotal'] ?? "";

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(16),
                  child: ListTile(
                    title: Text(noteText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => firestoreService.deleteNote(docId),
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () => openBox(docId: docId),
                          icon: Icon(Icons.edit, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
