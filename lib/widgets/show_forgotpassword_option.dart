import '../screenbarrel/screen_barrel.dart';

class ShowForgotPasswordOption extends StatelessWidget {
  const ShowForgotPasswordOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ResetPasswordScreen.id);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 5, top: 5).r,
          child: const Text(
            'Forgot Password ?',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}
