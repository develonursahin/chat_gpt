import 'package:chat_gpt/features/presentation/common/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';

class PurchaseCard extends StatelessWidget {
  final bool isSelected;
  final ValueChanged<bool?> onChanged;
  final String paymentName;
  final String paymentPrice;

  const PurchaseCard({
    super.key,
    required this.isSelected,
    required this.onChanged,
    required this.paymentName,
    required this.paymentPrice,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 106,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected
                ? ColorConstant.instance.green
                : ColorConstant.instance.darkGreen,
          ),
        ),
        color: ColorConstant.instance.black,
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Checkbox(
                  side: BorderSide(
                      color: ColorConstant.instance.darkGreen,
                      width: 2,
                      strokeAlign: 2),
                  value: isSelected,
                  shape: const CircleBorder(),
                  onChanged: onChanged,
                  fillColor: MaterialStateProperty.all<Color>(
                    isSelected
                        ? ColorConstant.instance.green
                        : Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 95,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: paymentName,
                      fontSize: 18,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    CustomTextWidget(
                      text: paymentPrice,
                      fontSize: 15,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> paymentOptions = [
  {
    'name': 'Weekly',
    'price': 'US\$3.99/week',
  },
  {
    'name': 'Monthly',
    'price': 'US\$19.99/month',
  },
  {
    'name': 'Annual',
    'price': 'US\$39.99/year',
  },
];
