import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prova_luis_honorato/features/theme/theme_colors.dart';
import 'package:prova_luis_honorato/features/theme/theme_dimensions.dart';
import 'package:theme_provider/theme_provider.dart';

/// Eu decidi colocar esse theme, pq eu nunca fui bom com temas, aí aproveitei pra est
class Themes {
  static const themeLightId = 'theme_light';
  static const themeDarkId = 'theme_dark';

  static AppTheme get themeLight {
    final light = ThemeData.light();
    return AppTheme(
      id: themeLightId,
      description: 'Default color scheme',
      data: light.copyWith(
        colorScheme: light.colorScheme.copyWith(
          primary: ThemeColors.primary,
          secondary: ThemeColors.bluePrimary,
        ),
        scaffoldBackgroundColor: ThemeColors.grayBackGround,
        unselectedWidgetColor: ThemeColors.grayDefault,
        disabledColor: ThemeColors.grayDisable,
        highlightColor: ThemeColors.salmon,
        splashColor: ThemeColors.salmon,
        shadowColor: ThemeColors.shadow,
        cardColor: ThemeColors.white,
        dialogBackgroundColor: ThemeColors.white,
        hintColor: ThemeColors.grayDefault,
        textSelectionTheme: light.textSelectionTheme.copyWith(
          cursorColor: ThemeColors.primary,
          selectionColor: ThemeColors.salmon,
          selectionHandleColor: ThemeColors.bluePrimary,
        ),
        floatingActionButtonTheme: light.floatingActionButtonTheme.copyWith(
            elevation: 16,
            backgroundColor: ThemeColors.bluePrimary,
            foregroundColor: ThemeColors.white,
            splashColor: ThemeColors.primary.withOpacity(0.2)),
        inputDecorationTheme: light.inputDecorationTheme.copyWith(
          border: _buildBorder(ThemeColors.grayDefault),
          enabledBorder: _buildBorder(ThemeColors.primary),
          focusedBorder: _buildBorder(ThemeColors.primary),
          errorBorder: _buildBorder(ThemeColors.redDanger),
          focusedErrorBorder: _buildBorder(ThemeColors.redDanger),
          errorStyle: const TextStyle(color: ThemeColors.redDanger),
          labelStyle: light.textTheme.bodyMedium,
        ),
        textTheme: TextTheme(
          bodyLarge: light.textTheme.bodyLarge?.copyWith(
            color: ThemeColors.primary,
            fontSize: ThemeDimensions.fontLarge,
            fontWeight: FontWeight.normal,
            height: 1.1,
          ),
          bodyMedium: light.textTheme.bodyMedium?.copyWith(
            color: ThemeColors.primary,
            fontWeight: FontWeight.normal,
            fontSize: ThemeDimensions.fontRegular,
            height: 1.1,
          ),
          displayMedium: light.textTheme.displaySmall?.copyWith(
            color: ThemeColors.primary,
          ),
          displaySmall: light.textTheme.displaySmall?.copyWith(
            color: ThemeColors.primary,
            fontSize: ThemeDimensions.fontVeryLarge,
            fontWeight: FontWeight.w500,
            height: 1.1,
          ),
          headlineMedium: light.textTheme.headlineMedium?.copyWith(
            color: ThemeColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.1,
          ),
          headlineSmall: light.textTheme.headlineSmall?.copyWith(
            fontSize: ThemeDimensions.fontLarge,
            color: ThemeColors.primary,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
          titleLarge: light.textTheme.titleLarge?.copyWith(
            color: ThemeColors.primary,
            fontSize: ThemeDimensions.fontRegular,
            fontWeight: FontWeight.normal,
            height: 1.4,
          ),
          titleMedium: light.textTheme.titleMedium?.copyWith(
            fontSize: ThemeDimensions.fontLarge,
            color: ThemeColors.primary,
            fontWeight: FontWeight.normal,
            height: 1.3,
          ),
          titleSmall: light.textTheme.titleSmall?.copyWith(
            fontSize: ThemeDimensions.fontRegular,
            color: ThemeColors.primary,
            letterSpacing: 0.1,
            fontWeight: FontWeight.normal,
            height: 1.1,
          ),
          labelLarge: light.textTheme.labelLarge?.copyWith(
            color: ThemeColors.white,
            fontSize: ThemeDimensions.fontLarge,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeColors.grayBlue,
          titleTextStyle: light.textTheme.titleLarge,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: ThemeColors.grayDefault,
            size: 24,
          ),
          actionsIconTheme: const IconThemeData(
            color: ThemeColors.grayDefault,
            size: 24,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarContrastEnforced: false,
          ),
        ),
        iconTheme: light.iconTheme.copyWith(
          size: 24,
          color: ThemeColors.primary,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: ThemeColors.primary,
          splashColor: ThemeColors.grayBlue,
          highlightColor: ThemeColors.salmon,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: ThemeColors.bluePrimary,
            textStyle: const TextStyle(
              color: ThemeColors.white,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColors.primary,
          ),
        ),
        dividerTheme: light.dividerTheme.copyWith(
          color: ThemeColors.grayDivider,
          thickness: 1,
          space: 1,
        ),
        snackBarTheme: light.snackBarTheme.copyWith(
          behavior: SnackBarBehavior.floating,
          actionTextColor: ThemeColors.bluePrimary,
        ),
        dropdownMenuTheme:
            DropdownMenuThemeData(textStyle: light.textTheme.displayMedium),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return ThemeColors.bluePrimary;
            }
            return null;
          }),
        ),
      ),
    );
  }

  static AppTheme get themeDark {
    return AppTheme(
      id: themeDarkId,
      description: 'Dark theme ',

      /// Fiquei com preguiça de fazer o tema dark kkkkkkkk

      data: themeLight.data.copyWith(),
    );
  }

  static OutlineInputBorder _buildBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: borderColor),
    );
  }
}
