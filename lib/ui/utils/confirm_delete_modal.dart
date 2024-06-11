import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmDeleteModal extends StatelessWidget {
  final String clientName;
  final String productName;
  final String productObservation;
  final double weight;
  final VoidCallback onConfirm;

  const ConfirmDeleteModal({
    Key? key,
    required this.clientName,
    required this.productName,
    required this.productObservation,
    required this.weight,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Text(
        AppLocalizations.of(context)!.productAlreadyWeighed,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildInfoRow(AppLocalizations.of(context)!.clientName, clientName),
          _buildInfoRow(AppLocalizations.of(context)!.productName, productName),
          _buildInfoRow(AppLocalizations.of(context)!.productObservation, productObservation),
          _buildInfoRow(AppLocalizations.of(context)!.weight, weight.toString()),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onConfirm,
            child: Text(
              AppLocalizations.of(context)!.deleteWeight,
              style: TextStyle(color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            AppLocalizations.of(context)!.close,
            style: TextStyle(color: Colors.black),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
