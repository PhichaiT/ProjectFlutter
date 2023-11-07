import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:widgets_basic/component/stream_note.dart';
import 'package:widgets_basic/main.dart';
import 'package:widgets_basic/todolist/add_note_screen.dart';
import 'package:widgets_basic/todolist/todolist.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginSucessPage extends StatefulWidget {
  LoginSucessPage({super.key});

  @override
  State<LoginSucessPage> createState() => _LoginSucessPageState();
}

class _LoginSucessPageState extends State<LoginSucessPage> {
  final user = FirebaseAuth.instance.currentUser;

  bool show = true;

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
    const MyApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove app bar shadow
        centerTitle: true,
        title: Text(
          '={  -Your Items List-  }=',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 34,
            fontStyle: FontStyle.normal,
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: signOutUser,
            icon: const Icon(
              Icons.login,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/background_image3.gif'), // Replace with your GIF asset path
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                setState(() {
                  show = true;
                });
              }
              if (notification.direction == ScrollDirection.reverse) {
                setState(() {
                  show = false;
                });
              }
              return true;
            },
            child: Column(
              children: [
                StreamNote(false),
                const Text(
                  'Click the button at the bottom to shop some more products',
                  style: TextStyle(color: Colors.green, fontSize: 20),
                ),
                StreamNote(true),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNoteScreen()));
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.shopping_cart,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
