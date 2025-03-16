import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AutoSizeTextPage extends StatefulWidget {
  const AutoSizeTextPage({super.key});

  @override
  State<AutoSizeTextPage> createState() => _AutoSizeTextPageState();
}

class _AutoSizeTextPageState extends State<AutoSizeTextPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Auto Size Text"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextField(
                controller: controller,
                maxLines: 5,
                onChanged: (value) {
                  setState(() {});
                },
                style: TextStyle(
                  color: Colors.purple,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.purple[50],
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Text...",
                  hintStyle: TextStyle(
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: AutoSizeText(
                  controller.text,
                  maxLines: 3,
                  minFontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
