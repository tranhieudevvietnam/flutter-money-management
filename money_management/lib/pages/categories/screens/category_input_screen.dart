part of '../category_export.dart';

class CategoryInputScreen extends StatefulWidget {
  static const String routeName = "/category/input/screen";
  const CategoryInputScreen({super.key});

  @override
  State<CategoryInputScreen> createState() => _CategoryInputScreenState();
}

class _CategoryInputScreenState extends State<CategoryInputScreen> {
  TextEditingController categoryInput = TextEditingController();

  IconData iconData = Icons.insert_emoticon_outlined;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar("Input category"),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //#region input category
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorConst.border)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final result = await NavigatorUtil.push(
                          routeName: CategoryListIconScreen.routeName,
                          context: context);
                      if (result != null) {
                        setState(() {
                          iconData = result;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        iconData,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: categoryInput,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 14),
                          hintText: "Enter name category.."),
                    ),
                  ),
                ],
              ),
            ),
            //#endregion
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorConst.border)),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.note_alt_outlined,
                        size: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.grey),
                            hintText: "Enter note..."),
                      )),
                    ],
                  ),
                  Column(
                    children: List.generate(
                      3,
                      (index) => Row(
                        children: [
                          Icon(iconData),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: Text(
                            "Category $index",
                          )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
