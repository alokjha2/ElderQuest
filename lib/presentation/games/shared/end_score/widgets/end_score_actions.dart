import 'package:flutter/material.dart';

import 'end_score_action_text.dart';

class EndScoreActions extends StatelessWidget {
  final VoidCallback onShare;
  final VoidCallback onExit;
  final VoidCallback onAgain;

  const EndScoreActions({
    super.key,
    required this.onShare,
    required this.onExit,
    required this.onAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EndScoreActionText(label: 'Share', onTap: onShare),
        EndScoreActionText(label: 'Exit', onTap: onExit),
        EndScoreActionText(label: 'Again', onTap: onAgain),
      ],
    );
  }
}