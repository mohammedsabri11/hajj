import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.child,
    required this.onPressed,
    this.verticalPorder = 10.0,
  });
  final Widget child;
  final double verticalPorder;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: verticalPorder,
                horizontal: 30.0,
              ),
              child: child,
            )));
  }
}
