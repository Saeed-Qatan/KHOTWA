import 'package:flutter/material.dart';
import 'package:khotwa/core/constants/color_constants.dart';
import 'package:khotwa/data/services/snackbar_services.dart';

class SnackbarVm extends ChangeNotifier {
  SnackbarServices _snackbarServices = SnackbarServices();
  SnackbarVm(this._snackbarServices);

  Future<void> submitDate() async {
    Future.delayed(Duration(seconds: 3));

    try {
      _snackbarServices.showSnackBar(
        "تمت العملية بنجاح",
        ColorConstants.success,
      );
    } catch (e) {
      _snackbarServices.showSnackBar("فشلت العملية....$e", ColorConstants.error);
    }
  }
}
