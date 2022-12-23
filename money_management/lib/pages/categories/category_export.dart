import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/constants/color_constant.dart';
import 'package:money_management/constants/material.dart';
import 'package:money_management/domain/categories/entities/category_model.dart';
import 'package:money_management/pages/categories/blocs/category/category_bloc.dart';
import 'package:money_management/utils/custom_toast_utils.dart';
import 'package:money_management/utils/navigator_utils.dart';
import 'package:money_management/widgets/appbar/base_appbar.dart';
import 'package:money_management/widgets/loading_widget.dart';

import 'blocs/category_input/category_input_bloc.dart';

part 'screens/category_screen.dart';
part 'screens/category_input_screen.dart';
part 'screens/category_list_icon_screen.dart';
