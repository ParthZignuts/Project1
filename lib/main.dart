
import 'screenbarrel/screen_barrel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme:ThemeData(
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
          ),
          home: const SplashScreen(),
          routes: routes,
        );
      },
    );
  }
}
