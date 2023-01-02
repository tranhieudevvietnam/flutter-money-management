import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_management/constants/color_constant.dart';
import 'package:money_management/constants/material.dart';
import 'package:money_management/domain/moneys/entities/money_model.dart';
import 'package:money_management/domain/moneys/entities/money_type.dart';
import 'package:money_management/pages/analysis/bloc/analysis_bloc.dart';
import 'package:money_management/pages/analysis/charts/line_chart/chart_line.dart';
import 'package:money_management/utils/datetime_utils.dart';
import 'package:money_management/utils/format_utils.dart';
import 'package:money_management/utils/navigator_utils.dart';
import 'package:money_management/widgets/appbar/base_appbar.dart';
import 'dart:math' as math;

import 'charts/pie_chart/pie_chart_view.dart';

part './views/analysis_collect_view.dart';
part './views/analysis_pay_view.dart';
part './views/hearder_view.dart';
part 'analysis_detail_screen.dart';
part 'analysis_screen.dart';

