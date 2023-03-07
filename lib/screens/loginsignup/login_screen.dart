import '../../screenbarrel/screen_barrel.dart';

class LoginScreen extends StatefulWidget {
  static const id = "loginscreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ConstSnackbar snackbar=ConstSnackbar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [ColorManager.lightGreen, ColorManager.darkGreen],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                    left: 20,
                    top: MediaQuery.of(context).size.height * 0.2,
                    right: 20).r,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const TitleTextWidget(titleText: 'Zignuts Technolab'),
                  SizedBox(
                    height: 30.h,
                  ),
                  UserDataTextFormField(
                    controller: _emailTextController,
                    label: 'email',
                    icon: Icons.email_outlined,
                    isPasswordType: false,
                    hintText: 'Enter Email',
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  UserDataTextFormField(
                    controller: _passwordTextController,
                    label: 'password',
                    icon: Icons.lock_outline,
                    isPasswordType: true,
                    hintText: 'Enter Password',
                    textInputAction: TextInputAction.done,
                  ),
                  const ShowForgotPasswordOption(),
                  SizedBox(
                    height: 15.h,
                  ),
                  FormSubmitButton(
                      buttonText: 'Login',
                      onSubmitForm: () =>_submitLoginForm()),
                  SizedBox(
                    height: 15.h,
                  ),
                  const ShowSignUpOption(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  //this function is used for submiting the loginForm
  _submitLoginForm(){
  if (_formKey.currentState!.validate()) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text)
        .then((value) {
      Get.toNamed(ShoppingList.id);
      snackbar.successSnackbar();
    }).onError((error, stackTrace)=>snackbar.failedSnackbar(error.toString()));
  }
}
}
