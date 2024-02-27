import 'package:final_project/models/user_card.dart';
import 'package:flutter/material.dart';

class CardViewer extends StatelessWidget {
  const CardViewer({super.key, required this.cardList});

  final List<UserCard> cardList;

  @override
  Widget build(BuildContext context) => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cardList.length,
        itemBuilder: (ctx, index) => Image.asset(
          cardList[index].imagePath,
          height: double.infinity,
          width: 300,
          fit: BoxFit.cover,
        ),
      );
}
