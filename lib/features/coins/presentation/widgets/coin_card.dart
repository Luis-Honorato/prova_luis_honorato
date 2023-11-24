import 'package:flutter/material.dart';
import 'package:prova_luis_honorato/features/coins/domain/entities/coin.dart';
import 'package:prova_luis_honorato/features/theme/theme_colors.dart';
import 'package:prova_luis_honorato/features/theme/theme_dimensions.dart';

class CoinCard extends StatelessWidget {
  final Coin coin;
  const CoinCard({
    super.key,
    required this.coin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ThemeColors.primary),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(coin.name),
          const SizedBox(
            height: ThemeDimensions.spacingSmall,
          ),
          Text('${coin.code}: ${coin.value}'),
        ],
      ),
    );
  }
}
