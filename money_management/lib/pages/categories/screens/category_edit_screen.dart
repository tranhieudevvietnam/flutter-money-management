part of '../category_export.dart';

class CategoryEditScreen extends StatefulWidget {
  static const String routeName = "/category/edit/screen";
  final CategoryModel data;
  const CategoryEditScreen({super.key, required this.data});

  @override
  State<CategoryEditScreen> createState() => _CategoryEditScreenState();
}

class _CategoryEditScreenState extends State<CategoryEditScreen> {
  late CategoryBloc categoryBloc;
  late CategoryInputBloc categoryInputBloc;
  TextEditingController noteInputController = TextEditingController();
  TextEditingController categoryInputController = TextEditingController();
  ValueNotifier<Map<String, IconData>> iconData =
      ValueNotifier({"savings_outlined": Icons.savings_outlined});

  @override
  void initState() {
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    categoryInputBloc = BlocProvider.of<CategoryInputBloc>(context);
    categoryBloc.add(CategoryGetOneEvent(data: widget.data));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar("Categories Edit", actions: [
        GestureDetector(
          onTap: () async {
            final result = await NavigatorUtil.push(
                routeName: CategoryInputScreen.routeName,
                context: context,
                arguments: {"data": widget.data});
            if (result != null) {
              categoryBloc.add(CategoryGetOneEvent(data: widget.data));
            }
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.add, size: 30),
          ),
        )
      ]),
      body: SafeArea(
          child: BlocListener<CategoryInputBloc, CategoryInputState>(
        listenWhen: (previous, current) =>
            current is CategoryChangeSuccess ||
            current is CategoryChangeFailure,
        listener: (context, stateInput) {
          if (stateInput is CategoryChangeSuccess ||
              stateInput is CategoryChangeFailure) {
            ///refresh data
            categoryBloc.add(CategoryGetOneEvent(data: widget.data));
            showMyDiaLog(
                context: context,
                title: "Success",
                message: stateInput.message!);
          }
        },
        child: BlocBuilder<CategoryBloc, CategoryState>(
          buildWhen: (previous, current) => current is CategoryGetOneSuccess,
          builder: (context, state) {
            if (state is CategoryGetOneSuccess) {
              final listData = state.data.subCategories ?? [];
              categoryInputController.text = state.data.name ?? "";
              iconData.value = {
                state.data.icon!: getIconByKey(state.data.icon!)
              };
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //#region input category
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Category name:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
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
                                          routeName:
                                              CategoryListIconScreen.routeName,
                                          context: context);
                                      if (result != null &&
                                          result
                                              is MapEntry<String, IconData>) {
                                        iconData.value = {
                                          result.key: result.value
                                        };
                                      }
                                    },
                                    child: ValueListenableBuilder(
                                      valueListenable: iconData,
                                      builder: (context, value, child) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Column(
                                            children: [
                                              Icon(
                                                value.values.first,
                                                size: 30,
                                              ),
                                              const Text(
                                                "Select icon",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: categoryInputController,
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
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.note_alt_outlined,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Note:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: ColorConst.border)),
                            child: TextField(
                              controller: noteInputController,
                              maxLines: 5,
                              minLines: 5,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  hintText: "Enter note..."),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            children: List.generate(listData.length, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        // An action can be bigger than the others.
                                        padding: const EdgeInsets.all(2),
                                        onPressed: (context) {
                                          widget.data.subCategories
                                              ?.remove(listData[index]);
                                          categoryInputBloc.add(
                                              CategoryEditEvent(widget.data));
                                          // categoryBloc.add(CategoryGetOneEvent(
                                          //     data: widget.data));
                                        },
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: ColorConst.error,
                                        icon: Icons.delete_outline_outlined,
                                      ),
                                      SlidableAction(
                                        // An action can be bigger than the others.
                                        padding: const EdgeInsets.all(2),
                                        onPressed: (context) async {
                                          final result =
                                              await NavigatorUtil.push(
                                                  routeName: CategoryInputScreen
                                                      .routeName,
                                                  context: context,
                                                  arguments: {
                                                "data": listData[index],
                                                "edit": true,
                                                "dataParent": widget.data
                                              });
                                          if (result != null) {
                                            categoryBloc.add(
                                                CategoryGetOneEvent(
                                                    data: widget.data));
                                          }
                                          // categoryInputBloc.add(
                                          //     CategoryEditEvent(
                                          //         listData[index]));
                                        },
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: ColorConst.text,
                                        icon: Icons.edit,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: ColorConst.primary,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Row(children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Icon(
                                                        getIconByKey(
                                                            listData[index]
                                                                .icon!),
                                                        size: 40,
                                                        color: Colors.white)),
                                                Text(
                                                  listData[index].name ?? "N/A",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                )
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //       color: Colors.white,
                                      //       border: Border.all(
                                      //           color: ColorConst.primary
                                      //               .withOpacity(.7)),
                                      //       borderRadius:
                                      //           const BorderRadius.only(
                                      //               bottomLeft:
                                      //                   Radius.circular(15),
                                      //               bottomRight:
                                      //                   Radius.circular(15))),
                                      //   child: Column(
                                      //       children: columnWidgets(
                                      //           listData[index].subCategories ??
                                      //               [])),
                                      // )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.data.name = categoryInputController.text;
                      widget.data.icon = iconData.value.keys.first;
                      widget.data.note = noteInputController.text;
                      categoryInputBloc.add(CategoryEditEvent(widget.data));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      margin: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: ColorConst.primary,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorConst.primary)),
                      child: const Center(
                          child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              );
            }
            return const LoadingWidget();
          },
        ),
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
            child: ItemCategoryView(
          data: data[index + i],
        )));
      } else {
        listWidgets.add(const Expanded(child: SizedBox()));
      }
      i++;
    }
    columnWidget.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listWidgets,
    ));
    if ((index + i) < data.length) {
      rowWidgets(columnWidget: columnWidget, data: data, index: index + i);
    }
    return columnWidget;
  }
}
