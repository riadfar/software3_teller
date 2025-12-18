import 'package:flutter/material.dart';
import '../../../../../../core/widgets/horizon_button.dart';
import '../../../../../core/theme/app_theme.dart';

class CreateCustomerBottomBar extends StatelessWidget {
  final int currentStep;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final bool isLastStep;

  const CreateCustomerBottomBar({
    super.key,
    required this.currentStep,
    required this.onBack,
    required this.onNext,
    this.isLastStep = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: AppTheme.bgColor,
      child: Row(
        children: [
          if (currentStep > 0) ...[
            Expanded(
              child: HorizonButton(
                text: "Back",
                onPressed: onBack,
                isOutlined: true,
              ),
            ),
            const SizedBox(width: 16),
          ],

          Expanded(
            flex: 2,
            child: HorizonButton(
              text: isLastStep ? "CONFIRM & CREATE" : "NEXT",
              onPressed: onNext,
              isOutlined: false,
            ),
          ),
        ],
      ),
    );
  }
}