import 'package:flutter/material.dart';
import 'package:widgets_basic/todolist/edit_note_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../component/firestore.dart';
import '../component/note_model.dart';

class ToDoList extends StatefulWidget {
  Note _note;
  ToDoList(this._note, {super.key});

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(120, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            imageWidget(),
            const SizedBox(
              width: 50,
            ),
            textWidget(),
          ],
        ),
      ),
    );
  }

  Column textWidget() {
    bool isDone = widget._note.isDone;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget._note.title,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 15,
            ),
            Transform.scale(
              scale:
                  1.25, // Change this value to adjust the size of the Checkbox
              child: Checkbox(
                activeColor: Colors.green,
                value: isDone,
                onChanged: (value) {
                  setState(() {
                    isDone = !isDone;
                    Firestore_Datasource().isdone(widget._note.id, isDone);
                  });
                },
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          widget._note.subtitle,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        btnWidget(),
      ],
    );
  }

  Row btnWidget() {
    return Row(
      children: [
        Container(
          width: 90,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timelapse,
                color: Colors.white,
                size: 25,
              ),
              Text(
                widget._note.time,
                style: TextStyle(fontSize: 14, color: Colors.white),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditNoteScreen(widget._note)));
          },
          child: Container(
            width: 90,
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 239, 82, 82),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 25,
                ),
                Text(
                  'edit',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container imageWidget() {
    return Container(
      width: 400,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.amber,
        image: DecorationImage(
          image: AssetImage('assets/images/${widget._note.image}.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
