import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/constants/color_constant.dart';
import 'package:money_management/constants/material.dart';
import 'package:money_management/domain/categories/entities/category_model.dart';
import 'package:money_management/domain/moneys/entities/money_type.dart';
import 'package:money_management/pages/categories/category_export.dart';
import 'package:money_management/pages/input_money/blocs/input_money_bloc.dart';
import 'package:money_management/utils/custom_toast_utils.dart';
import 'package:money_management/utils/navigator_utils.dart';
import 'package:money_management/widgets/text_field/mask_text_input_formatter.dart';
import '../../utils/datetime_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'input_screen.dart';
part 'input_collect/input_collect_view.dart';
part 'input_pay/input_pay_view.dart';
part 'views/input_view.dart';
