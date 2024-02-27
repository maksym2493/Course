import 'dart:ui';

import 'package:final_project/main.dart';
import 'package:final_project/models/material.dart';
import 'package:final_project/screens/material.dart';
import 'package:flutter/material.dart';

class MaterialElement extends StatelessWidget {
  const MaterialElement({
    super.key,
    required this.material,
  });

  final UserMaterial material;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MaterialScreen(material: material),
          ),
        ),
        child: Column(
          children: [
            Text(
              style: kText4,
              material.title,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    material.imagePath,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    style: kText5,
                    material.description,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
          ],
        ),
      );
}
