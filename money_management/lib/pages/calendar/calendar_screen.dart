part of 'calendar_export.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late CalendarBloc calendarBloc;

  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  List<EventModel> listEvents = [];
  List<MoneyModel> listData = [];

  @override
  void initState() {
    super.initState();
    calendarBloc = BlocProvider.of<CalendarBloc>(context);
    calendarBloc.add(CalendarInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SettingBloc, SettingState>(
              buildWhen: (previous, current) =>
                  current is SettingChangeLanguage,
              builder: (context, state) {
                SettingChangeLanguage stateLanguage;
                if (state is SettingChangeLanguage) {
                  stateLanguage = state;
                } else {
                  final local = HiveUtil.boxLocal.get(HiveKeyConstant.language);
                  stateLanguage = SettingChangeLanguage(Locale(local ?? "vi"));
                }
                return BlocBuilder<CalendarBloc, CalendarState>(
                  buildWhen: (previous, current) =>
                      current is CalendarGetAllListDataSuccess,
                  builder: (context, state) {
                    if (state is CalendarGetAllListDataSuccess) {
                      listEvents = state.listData;
                    }

                    return TableCalendar<EventModel>(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      locale: stateLanguage.locale.languageCode,
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      availableCalendarFormats: {
                        CalendarFormat.month:
                            AppLocalizations.of(context)!.month,
                        CalendarFormat.twoWeeks:
                            "2 ${AppLocalizations.of(context)!.week}",
                        CalendarFormat.week: AppLocalizations.of(context)!.week
                      },
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      calendarStyle: const CalendarStyle(
                          // weekendTextStyle:
                          // TextStyle().copyWith(color: Colors.blue[800]),
                          ),
                      headerStyle: HeaderStyle(
                        formatButtonTextStyle:
                            const TextStyle(fontSize: 16, color: Colors.white),
                        formatButtonDecoration: BoxDecoration(
                            // boxShadow: [BoxShadow()],
                            color: ColorConst.primary,
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        debugPrint("onDaySelected");
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          setState(() {
                            _focusedDay = focusedDay;
                            _selectedDay = selectedDay;
                            // _selectedEvents = _getEventsForDay(selectedDay);
                          });

                          calendarBloc
                              .add(CalendarGetAllByDateEvent(selectedDay));
                        }
                      },
                      eventLoader: (day) {
                        return listEvents.where((element) {
                          if (DateTime(
                                      element.dateTime.year,
                                      element.dateTime.month,
                                      element.dateTime.day)
                                  .difference(
                                      DateTime(day.year, day.month, day.day))
                                  .inDays ==
                              0) {
                            return true;
                          }
                          return false;
                        }).toList();
                      },
                      calendarBuilders: CalendarBuilders(
                        selectedBuilder: (context, date, _) {
                          return Container(
                            //see difference between margin and padding below: Margin: Out (for itself), padding: In (for its child)
                            // margin: EdgeInsets.all(4.0.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorConst.primary),
                            width: 46,
                            height: 46,
                            child: Center(
                              child: Text(
                                '${date.day}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          );
                        },
                        todayBuilder: (context, date, _) {
                          return Container(
                            //see difference between margin and padding below: Margin: Out (for itself), padding: In (for its child)
                            // margin: EdgeInsets.all(4.0.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: ColorConst.primary)),
                            width: 46,
                            height: 46,
                            child: Center(
                              child: Text(
                                '${date.day}',
                                style: const TextStyle(
                                    fontSize: 16, color: ColorConst.primary),
                              ),
                            ),
                          );
                        },
                        markerBuilder: (context, date, events) {
                          if (events.isNotEmpty) {
                            return Positioned(
                              right: 1,
                              bottom: 1,
                              child: _buildEventsMarker(date, events),
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
            Expanded(
                child: BlocBuilder<CalendarBloc, CalendarState>(
              buildWhen: (previous, current) =>
                  current is CalendarGetAllByDateSuccess,
              builder: (context, state) {
                if (state is CalendarGetAllByDateSuccess) {
                  listData = state.listData;
                }
                return ListView(
                  children: List.generate(
                      listData.length,
                      (index) => Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 1, color: ColorConst.border)),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: getColorByType(
                                                  listData[index].moneyType!)),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Icon(
                                        getIconByKey(
                                            listData[index].category.icon!),
                                        color: getColorByType(
                                            listData[index].moneyType!),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${listData[index].category.name}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConst.text),
                                      ),
                                      Text(
                                        "${listData[index].createDated.dateTimeConvertString(type: "HH:mm dd/MM/yyyy")}",
                                        style: const TextStyle(
                                            height: 1.5,
                                            fontSize: 12,
                                            color: ColorConst.text),
                                      ),
                                    ],
                                  )),
                                  Text(
                                    "${FormatUtils.instant.moneyFormat(money: listData[index].money)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: getColorByType(
                                            listData[index].moneyType!)),
                                  ),
                                  const Icon(
                                    Icons.navigate_next_outlined,
                                    color: ColorConst.text,
                                  )
                                ]),
                          )),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  getColorByType(MoneyType moneyType) {
    return moneyType == MoneyType.pay ? ColorConst.error : ColorConst.success;
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    double width = events.length < 100 ? 18 : 28;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          gradient: const LinearGradient(
            begin: Alignment(-1, 0.0),
            end: Alignment(1.0, 0),
            colors: <Color>[ColorConst.error, ColorConst.success],
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(100)),
      width: width,
      height: 18.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.0,
          ),
        ),
      ),
    );
  }
}
