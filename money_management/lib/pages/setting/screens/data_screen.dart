part of '../setting_export.dart';

class DataScreen extends StatefulWidget {
  static const String routeName = "/setting/data/screen";
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  late SettingBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<SettingBloc>(context);
    bloc.add(SettingCountDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(AppLocalizations.of(context)!.dataCurrent),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<SettingBloc, SettingState>(
          listenWhen: (previous, current) => current is SettingDeleteDataState,
          listener: (context, state) {
            if (state is SettingDeleteDataState) {
              if (state.success == false) {
                showMyDiaLog(
                    context: context,
                    title: AppLocalizations.of(context)!.success,
                    message: state.message!);
              } else {
                showMyDiaLog(
                    context: context,
                    title: AppLocalizations.of(context)!.success,
                    message:
                        "${AppLocalizations.of(context)!.update} ${AppLocalizations.of(context)!.success.toLowerCase()}");
              }
            }
          },
          child: BlocBuilder<SettingBloc, SettingState>(
            buildWhen: (previous, current) =>
                current is SettingCountDataLocalState,
            builder: (context, state) {
              if (state is SettingCountDataLocalState) {
                return Column(
                  children: [
                    ItemDataSettingWidget(
                        callback: () {
                          showMyDiaLogConfirm(
                              context: context,
                              title: AppLocalizations.of(context)!.warning,
                              message:
                                  "${AppLocalizations.of(context)!.textWarningDelete} ${AppLocalizations.of(context)!.dataCategory.toLowerCase()}? ",
                              onAccept: () {
                                bloc.add(SettingDeleteDataEvent(
                                    typeDelete:
                                        TypeSettingDelete.dataCategory));
                              },
                              onClose: () {});
                        },
                        imagePath: "assets/languages/icon_vietnam.png",
                        count: state.countRowCategory,
                        title: AppLocalizations.of(context)!.dataCategory),
                    ItemDataSettingWidget(
                        callback: () => {
                              showMyDiaLogConfirm(
                                  context: context,
                                  title: AppLocalizations.of(context)!.warning,
                                  message:
                                      "${AppLocalizations.of(context)!.textWarningDelete} ${AppLocalizations.of(context)!.dataCategory.toLowerCase()}? ",
                                  onAccept: () {
                                    bloc.add(SettingDeleteDataEvent(
                                        typeDelete:
                                            TypeSettingDelete.dataMoney));
                                  },
                                  onClose: () {})
                            },
                        imagePath: "assets/languages/icon_english.png",
                        count: state.countRowMoney,
                        title: AppLocalizations.of(context)!.dataMoney),
                  ],
                );
              }
              return const LoadingWidget();
            },
          ),
        ),
      )),
    );
  }
}

class ItemDataSettingWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final int count;
  final VoidCallback callback;
  const ItemDataSettingWidget(
      {Key? key,
      required this.title,
      required this.imagePath,
      required this.count,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: ColorConst.border),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Row(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Icon(
                    Icons.snippet_folder_outlined,
                    size: 30,
                    color: ColorConst.primary,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, color: ColorConst.text),
                )
              ]),
            ),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 16, color: ColorConst.hintText),
            )
          ],
        ),
      ),
    );
  }
}
