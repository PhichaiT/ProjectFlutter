import 'package:flutter/material.dart';
import 'package:widgets_basic/component/firestore.dart';
import 'package:widgets_basic/component/note_model.dart';

class GifItem {
  final String imagePath;
  final String price;
  final String specialFunction;

  GifItem(
      {required this.imagePath,
      required this.price,
      required this.specialFunction});
}

List<GifItem> gifItems = [
  GifItem(
    imagePath: 'assets/images/0.gif',
    price: '300 Dollars',
    specialFunction: 'Neon Light on foot',
  ),
  GifItem(
    imagePath: 'assets/images/1.gif',
    price: '175 Dollars',
    specialFunction: 'Comfortable every step',
  ),
  GifItem(
    imagePath: 'assets/images/2.gif',
    price: '150 Dollars',
    specialFunction: 'Formal and minimal',
  ),
  GifItem(
    imagePath: 'assets/images/3.gif',
    price: '200 Dollars',
    specialFunction: 'Classy and soft shoes',
  ),
  GifItem(
    imagePath: 'assets/images/4.gif',
    price: '270 Dollars',
    specialFunction: 'Blight and Elegant',
  ),
  GifItem(
    imagePath: 'assets/images/5.gif',
    price: '350 Dollars',
    specialFunction: 'High quality color and cottons',
  ),
  GifItem(
    imagePath: 'assets/images/6.gif',
    price: '200 Dollars',
    specialFunction: 'Complex and well made doodle shoes',
  ),
  GifItem(
    imagePath: 'assets/images/7.gif',
    price: '1000 Dollars',
    specialFunction: 'Customizable according to customers',
  ),
];

class EditNoteScreen extends StatefulWidget {
  Note _note;
  EditNoteScreen(this._note, {super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController? title;
  TextEditingController? subtitle;

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  int indexx = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = TextEditingController(text: widget._note.title);
    subtitle = TextEditingController(text: widget._note.subtitle);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title_widgets(),
            const SizedBox(height: 20),
            subtite_wedgite(),
            const SizedBox(height: 20),
            imagess(),
            const SizedBox(height: 20),
            button()
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            minimumSize: const Size(170, 48),
          ),
          onPressed: () {
            Firestore_Datasource().Update_Note(
                widget._note.id, indexx, title!.text, subtitle!.text);
            Navigator.pop(context);
          },
          child: const Text('Update'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            minimumSize: const Size(170, 48),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Container imagess() {
    return Container(
      height: 216,
      child: ListView.builder(
        itemCount: gifItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                indexx = index;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 7 : 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: indexx == index ? Colors.greenAccent : Colors.grey,
                  ),
                ),
                width: 220,
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Image.asset(gifItems[index].imagePath),
                    Container(
                      color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment
                                .center, // Align texts in the middle vertically
                            child: Text(
                              'Price: ${gifItems[index].price}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Container(
                              alignment: Alignment
                                  .center, // Align texts in the middle vertically
                              child: Text(
                                'Special Function: ${gifItems[index].specialFunction}',
                                style: TextStyle(
                                  fontSize: 13.85,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget title_widgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: title,
          focusNode: _focusNode1,
          style: const TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText: 'title',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xffc5c5c5),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2.0,
                ),
              )),
        ),
      ),
    );
  }

  Padding subtite_wedgite() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          maxLines: 3,
          controller: subtitle,
          focusNode: _focusNode2,
          style: const TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'subtitle',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.green,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
