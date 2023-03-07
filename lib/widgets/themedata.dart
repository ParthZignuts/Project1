import '../screenbarrel/screen_barrel.dart';

ThemeData themeData() {
  return  ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: ColorManager.darkGreen),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.lightGreen,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.darkGreen),
      ),
    ),
  );
}
