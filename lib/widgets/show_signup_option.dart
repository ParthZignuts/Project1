import '../screenbarrel/screen_barrel.dart';

class ShowSignUpOption extends StatelessWidget {
  const ShowSignUpOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have account?",
          style: TextStyle(color: ColorManager.white2),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, SignUpScreen.id);
          },
          child: const Text(
            ' Sign Up',
            style: TextStyle(
                color: ColorManager.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
