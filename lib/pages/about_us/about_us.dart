import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:Driver/Data.dart';
import 'package:Driver/config/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Driver/core/authentication_service.dart';
import 'package:Driver/components/custom_button.dart';
import 'package:Driver/utils/loader.dart';
import 'package:Driver/pages/LoginPage.dart';
import 'package:get/get.dart';
String s = Get.parameters['vale'].toString();
  final CollectionReference users =FirebaseFirestore.instance.collection('users');
const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ));

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
    return Scaffold(
            
appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: blueColor,
        title: const Text(
          "PARKR",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body:SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo2.png'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Hi ${AuthenticationService.auth.currentUser!.displayName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome to your profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: ${AuthenticationService.auth.currentUser!.email}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 100,
                child: CustomButton(
                  label: 'LOGOUT',
                  color: Colors.black,
                  onPressed: () async {
                    LoaderX.show(context);
                    await AuthenticationService.auth.signOut().then((value) {
                      LoaderX.hide();
                      Get.offAll(LoginScreen());
                    });
                  },
                  size: size,
                  textColor: Colors.white,
                  borderSide: BorderSide.none,
                ),
              )
            ],
          ),
        ),
      ),
    
      
      ); 
  }
  Stream<QuerySnapshot> getNotesStream() {
    try {
      final notesStream =users.orderBy('timestamp', descending: true).snapshots();
      return notesStream;
    } catch (e) {
      rethrow;
    }
  }
}
