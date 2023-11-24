import 'package:flutter/material.dart';
import 'package:prova_luis_honorato/features/theme/themes.dart';
import 'package:prova_luis_honorato/features/navigation/navigator_base.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  runApp(
    ThemeProvider(
      themes: [
        Themes.themeLight,
        Themes.themeDark,
      ],
      child: ThemeConsumer(
        child: Builder(builder: (themeContext) {
          return MaterialApp(
            theme: ThemeProvider.themeOf(themeContext).data,
            debugShowCheckedModeBanner: false,
            home: const NavigatorBase(),
          );
        }),
      ),
    ),
  );
}
