import 'package:final_project/main.dart';
import 'package:final_project/models/material.dart';
import 'package:final_project/screens/request_material.dart';
import 'package:final_project/widgets/material_searcher/material_viewer.dart';
import 'package:final_project/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({
    super.key,
    required this.materials,
  });

  final List<UserMaterial> materials;

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final materials = _searchText == ''
        ? widget.materials
        : widget.materials
            .where(
              (material) =>
                  material.title.toLowerCase().contains(_searchText) ||
                  material.description.toLowerCase().contains(_searchText),
            )
            .toList();

    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(title: 'Навчання'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: kText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        hintText: 'Введіть назву',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onChanged: (value) => setState(
                        () => _searchText = value.toLowerCase(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Image.asset(
                      'assets/images/education_images/search_ico.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: MaterialViewer(materials: materials),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const RequestMaterialScreen(),
                        ),
                      ),
                      icon: const Icon(
                        Icons.add,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
