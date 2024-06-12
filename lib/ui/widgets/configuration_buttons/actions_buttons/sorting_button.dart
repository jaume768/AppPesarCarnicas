import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../structure/bloc/article/article_bloc.dart';

class SortingButton extends StatelessWidget {
  final BuildContext context;
  final String text;
  final String sortField;
  final ArticleLoaded state;

  const SortingButton({
    required this.context,
    required this.text,
    required this.sortField,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = state.sortField == sortField;
    bool isAscending = isActive ? state.isAscending : false;

    return ElevatedButton(
      onPressed: () {
        bool newAscending = isActive ? !state.isAscending : false;
        context.read<ArticleBloc>().add(SortArticles(sortField: sortField, isAscending: newAscending));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.blue : Colors.grey,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        elevation: isActive ? 4 : 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          Icon(
            isAscending ? Icons.arrow_upward : Icons.arrow_downward,
            size: 16,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
