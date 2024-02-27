import 'package:final_project/models/material.dart';
import 'package:final_project/widgets/material_searcher/material_element.dart';
import 'package:flutter/material.dart';

class MaterialViewer extends StatelessWidget {
  const MaterialViewer({
    super.key,
    required this.materials,
  });

  final List<UserMaterial> materials;

  @override
  Widget build(BuildContext context) => materials.isEmpty
      ? const Text('Nothing here')
      : ListView.builder(
          itemCount: materials.length,
          itemBuilder: (ctx, index) => MaterialElement(
            key: ValueKey(materials[index].id),
            material: materials[index],
          ),
        );
}
