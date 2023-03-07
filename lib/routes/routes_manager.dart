import '../screenbarrel/screen_barrel.dart';

final Map<String,Widget Function(BuildContext)> routes=
  {
    SplashScreen.id: (context) => const SplashScreen(),
    LoginScreen.id: (context) => const LoginScreen(),
    ProductDetailScreen.id: (context) => const ProductDetailScreen(),
    ResetPasswordScreen.id: (context) => const ResetPasswordScreen(),
    ShoppingList.id: (context) => const ShoppingList(),
    SignUpScreen.id: (context) => const SignUpScreen(),
    CocktailViewScreen.id:(context)=> const CocktailViewScreen(),

  };
