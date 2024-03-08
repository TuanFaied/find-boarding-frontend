import 'package:flutter/material.dart';

import '../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: defaultPadding * 4),
        const Text(
          "LOGIN",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: defaultPadding * 6),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset("assets/images/Logo.png"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 4),
      ],
    );
  }
}
