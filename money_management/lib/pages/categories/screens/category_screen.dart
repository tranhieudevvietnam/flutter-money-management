part of '../category_export.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = "/category/screen";

  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoryBloc categoryBloc;

  @override
  void initState() {
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    categoryBloc.add(CategoryGetAllEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar("Categories", actions: [
        GestureDetector(
          onTap: () async {
            final result = await NavigatorUtil.push(
                routeName: CategoryInputScreen.routeName, context: context);
            if (result != null) {
              categoryBloc.add(CategoryGetAllEvent());
            }
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.add, size: 30),
          ),
        )
      ]),
      body: SafeArea(child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryGetAllSuccess) {
            return ListView(
              children: List.generate(state.listData.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          NavigatorUtil.pop(
                              context: context, result: state.listData[index]);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: ColorConst.primary,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Icon(
                                          getIconByKey(
                                              state.listData[index].icon!),
                                          size: 40,
                                          color: Colors.white)),
                                  Text(
                                    state.listData[index].name ?? "N/A",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  )
                                ]),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final result = await NavigatorUtil.push(
                                      routeName: CategoryInputScreen.routeName,
                                      context: context,
                                      arguments: {
                                        "data": state.listData[index]
                                      });
                                  if (result != null) {
                                    categoryBloc.add(CategoryGetAllEvent());
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Icon(
                                    Icons.add,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: ColorConst.primary.withOpacity(.7)),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: Column(
                            children: columnWidgets(
                                state.listData[index].subCategories ?? [])),
                      )
                    ],
                  ),
                );
              }),
            );
          }
          return const LoadingWidget();
        },
      )),
    );
  }

  List<Widget> columnWidgets(List<CategoryModel> data) {
    List<Widget> listWidgets = [];
    if (data.isEmpty) {
      listWidgets.add(const SizedBox(
        height: 20,
      ));
    }
    rowWidgets(columnWidget: listWidgets, data: data, index: 0);
    return listWidgets;
  }

  rowWidgets(
      {required int index,
      required List<CategoryModel> data,
      required List<Widget> columnWidget}) {
    List<Widget> listWidgets = [];
    int length = 4;
    int i = 0;
    while (i < length) {
      if ((index + i) < data.length) {
        listWidgets.add(Expanded(
            child: ItemCategoryWidget(
          data: data[index + i],
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

class ItemCategoryWidget extends StatelessWidget {
  final CategoryModel data;
  const ItemCategoryWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pop(context: context, result: data);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
