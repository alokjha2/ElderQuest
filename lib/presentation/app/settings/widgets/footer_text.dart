import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class FooterText extends StatelessWidget {
  const FooterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: const TextSpan(
          style: AppTextStyles.settingsFooter,
          children: [
            TextSpan(text: 'Our '),
            TextSpan(
              text: 'Terms and Privacy Policy.',
              style: AppTextStyles.settingsFooterLink,
            ),
          ],
        ),
      ),
    );
  }
}
