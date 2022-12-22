part of '../category_export.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = "/category/screen";

  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Category")),
      body: SafeArea(
          child: Column(
        children: const [Icon(Icons.insert_emoticon_outlined)],
      )),
    );
  }
}
