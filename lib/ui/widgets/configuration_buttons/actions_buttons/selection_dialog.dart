import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../structure/bloc/configuration/configuration_bloc.dart';
import '../../../../structure/bloc/configuration/configuration_event.dart';
import '../../../../structure/bloc/configuration/configuration_state.dart';

void showSelectionDialog(BuildContext context, bool isScale) {
  context.read<ConfigurationBloc>().add(FetchConfiguration());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<ConfigurationBloc, ConfigurationState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final items = isScale ? state.scales : state.printers;
          return AlertDialog(
            title: Text(isScale ? AppLocalizations.of(context)!.selectScale : AppLocalizations.of(context)!.selectPrinter),
            content: SingleChildScrollView(
              child: ListBody(
                children: items.map((item) {
                  return ListTile(
                    title: Text(item['name']),
                    onTap: () {
                      if (isScale) {
                        context.read<ConfigurationBloc>().add(SelectScale(item));
                      } else {
                        context.read<ConfigurationBloc>().add(SelectPrinter(item));
                      }
                      Navigator.of(context).pop();
                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
      );
    },
  );
}
