import '../../screenbarrel/screen_barrel.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splashscreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get cureentUser => _firebaseAuth.currentUser;


  @override
  void initState() {
    super.initState();
    _navigateToLoginScreen();
  }

  _navigateToLoginScreen() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    if (cureentUser == null  ) {
      Get.toNamed(LoginScreen.id);
    } else {
      Get.toNamed(ShoppingList.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorManager.green,ColorManager.lightGreen],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          const Center(
            child: Text(
              'ZIGNUTS',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
