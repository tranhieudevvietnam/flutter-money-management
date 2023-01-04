part of '../setting_export.dart';

class LanguageScreen extends StatefulWidget {
  static const String routeName = "/setting/language/screen";
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late SettingBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<SettingBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(AppLocalizations.of(context)!.languageTitle),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ItemLanguageWidget(
                callback: () =>
                    bloc.add(SettingChangeLanguageEvent(const Locale("vi"))),
                imagePath: "assets/languages/icon_vietnam.png",
                title: AppLocalizations.of(context)!.vietName),
            ItemLanguageWidget(
                callback: () =>
                    bloc.add(SettingChangeLanguageEvent(const Locale("en"))),
                imagePath: "assets/languages/icon_english.png",
                title: AppLocalizations.of(context)!.english),
          ],
        ),
      )),
    );
  }
}

class ItemLanguageWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback callback;
  const ItemLanguageWidget(
      {Key? key,
      required this.title,
      required this.imagePath,
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
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              imagePath,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
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
    );
  }
}
