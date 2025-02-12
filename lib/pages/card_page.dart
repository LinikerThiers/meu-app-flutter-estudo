import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          child: Card(
            elevation: 4,
            shadowColor: Colors.grey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/my-wallet-logo.png",
                        height: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Meu Card",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: Text("Ler Mais", style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),)
                        )
                      ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
