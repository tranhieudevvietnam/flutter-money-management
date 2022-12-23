part of '../category_export.dart';

class CategoryInputScreen extends StatefulWidget {
  static const String routeName = "/category/input/screen";
  final CategoryModel? data;
  const CategoryInputScreen({super.key, this.data});

  @override
  State<CategoryInputScreen> createState() => _CategoryInputScreenState();
}

class _CategoryInputScreenState extends State<CategoryInputScreen> {
  TextEditingController categoryInput = TextEditingController();
  TextEditingController noteInput = TextEditingController();

  Map<String, IconData> iconData = {"savings_outlined": Icons.savings_outlined};

  late CategoryInputBloc inputBloc;
  @override
  void initState() {
    inputBloc = BlocProvider.of<CategoryInputBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryInputBloc, CategoryInputState>(
      listenWhen: (previous, current) =>
          current is CategoryInputCreateSuccess ||
          current is CategoryInputCreateFailure,
      listener: (context, state) {
        if (state is CategoryInputCreateSuccess) {
          customToastUtils(context,
              type: ToastType.success, msg: state.message);
          NavigatorUtil.pop(context: context,result: true);
          return;
        }
        if (state is CategoryInputCreateFailure) {
          showMyDiaLog(
              context: context, title: "Error", message: state.message!);
          return;
        }
      },
      child: Scaffold(
        appBar: const BasicAppBar("Input category"),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                            routeName: CategoryListIconScreen.routeName,
                            context: context);
                        if (result != null &&
                            result is MapEntry<String, IconData>) {
                          setState(() {
                            iconData = {result.key: result.value};
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Icon(
                              iconData.values.first,
                              size: 30,
                            ),
                            const Text(
                              "Select icon",
                              style: TextStyle(
                                  fontSize: 10, fontStyle: FontStyle.italic),
                            )
                          ],
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
                  controller: noteInput,
                  maxLines: 5,
                  minLines: 5,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      hintText: "Enter note..."),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              GestureDetector(
                onTap: () {
                  if (categoryInput.text.isEmpty == true) {
                    showMyDiaLog(
                        context: context,
                        title: "Warning",
                        message: "Please enter category name");
                  } else {
                    if (widget.data != null) {
                      inputBloc.add(CategoryCreateSubCategoryEvent(
                          data: widget.data!,
                          categoryName: categoryInput.text,
                          note: noteInput.text,
                          iconData: iconData.keys.first));
                    } else {
                      inputBloc.add(CategoryCreateEvent(
                          categoryName: categoryInput.text,
                          note: noteInput.text,
                          iconData: iconData.keys.first));
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
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
              )
            ],
          ),
        )),
      ),
    );
  }
}
