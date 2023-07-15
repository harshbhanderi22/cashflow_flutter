import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/login_method_circle.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/view_model/Auth%20Providers/google_sign_in_provider.dart';
import 'package:provider/provider.dart';

class OtherLoginMethod extends StatelessWidget {
  const OtherLoginMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<GoogleSingInProivder>(
            builder: ((context, value, child) {
          return LoginMethodCircle(
            path: "assests/images/google.png",
            onTap: () {
              value.googleLogIn(context);
            },
          );
        })),
        const SizedBox(
          width: 20,
        ),
        LoginMethodCircle(
          path: "assests/images/facebook2.png",
          onTap: () {
            GeneralUtils.showToast("Coming Soon");
          },
        ),
      ],
    );
  }
}
