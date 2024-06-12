import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../structure/bloc/configuration/configuration_bloc.dart';
import '../../../structure/bloc/configuration/configuration_state.dart';
import 'actions_buttons/action_button.dart';
import 'actions_buttons/articles_dialog.dart';

class ActionsColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ConfigurationBloc, ConfigurationState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              ActionButton(
                context: context,
                text: AppLocalizations.of(context)!.selectScale,
                displayText: state.selectedScale != null
                    ? AppLocalizations.of(context)!.scaleSelected(state.selectedScale['name'])
                    : AppLocalizations.of(context)!.selectScale,
                color: Colors.lightBlue,
                isScale: true,
              ),
              const SizedBox(height: 10),
              ActionButton(
                context: context,
                text: AppLocalizations.of(context)!.selectPrinter,
                displayText: state.selectedPrinter != null
                    ? AppLocalizations.of(context)!.printerSelected(state.selectedPrinter['name'])
                    : AppLocalizations.of(context)!.selectPrinter,
                color: Colors.pink,
                isScale: false,
              ),
              const SizedBox(height: 10),
              ActionButton(
                context: context,
                text: AppLocalizations.of(context)!.viewTotalsByArticle,
                displayText: AppLocalizations.of(context)!.viewTotalsByArticle,
                color: Colors.red,
                onPressed: () => showArticlesDialog(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
