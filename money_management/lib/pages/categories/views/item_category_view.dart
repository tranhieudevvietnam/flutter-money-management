part of '../category_export.dart';

class ItemCategoryView extends StatelessWidget {
  final CategoryModel data;
  const ItemCategoryView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pop(context: context, result: data);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    getIconByKey(data.icon!),
                    size: 40,
                  )),
              Text(
                data.name!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                ),
              )
            ]),
      ),
    );
  }
}
