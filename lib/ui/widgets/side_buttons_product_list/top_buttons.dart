import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'custom_button.dart';

class TopButtons extends StatelessWidget {
  final VoidCallback onReviewComplete;

  const TopButtons({
    required this.onReviewComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomButton(
            text: AppLocalizations.of(context)!.reviewComplete,
            color: Colors.lightBlue,
            onPressed: onReviewComplete,
          ),
        ),
        Expanded(
          child: CustomButton(
            text: AppLocalizations.of(context)!.changeConfiguration,
            color: Colors.yellow.shade300,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
