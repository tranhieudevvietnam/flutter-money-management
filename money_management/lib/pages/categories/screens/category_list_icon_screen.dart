part of '../category_export.dart';

class CategoryListIconScreen extends StatefulWidget {
  static const String routeName = "/category/list/icon/screen";
  const CategoryListIconScreen({super.key});

  @override
  State<CategoryListIconScreen> createState() => _CategoryListIconScreenState();
}

class _CategoryListIconScreenState extends State<CategoryListIconScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar("Select Icons"),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(16),
        children: columnWidgets(),
      )),
    );
  }

  List<Widget> columnWidgets() {
    List<Widget> listWidgets = [];
    rowWidgets(columnWidget: listWidgets, data: materialIcons, index: 0);
    return listWidgets;
  }

  rowWidgets(
      {required int index,
      required Map data,
      required List<Widget> columnWidget}) {
    List<Widget> listWidgets = [];
    int length = 4;
    int i = 0;
    while (i < length) {
      if ((index + i) < data.length) {
        final iconData = data.entries.elementAt(index + i).value;
        listWidgets.add(Expanded(
            child: InkWell(
          onTap: () {
            NavigatorUtil.pop(context: context, result: iconData);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              iconData,
              size: 40,
            ),
          ),
        )));
      } else {
        listWidgets.add(const Expanded(child: SizedBox()));
      }
      i++;
    }
    columnWidget.add(Row(
      children: listWidgets,
    ));
    if ((index + i) < data.length) {
      rowWidgets(columnWidget: columnWidget, data: data, index: index + i);
    }
    return columnWidget;
  }
}
