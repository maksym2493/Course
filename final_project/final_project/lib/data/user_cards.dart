import 'package:final_project/models/user_card.dart';

final List<UserCard> userCards = [
  for (var i = 1; i <= 3; i++)
    UserCard(imagePath: 'assets/images/card_images/card_$i.png'),
];
