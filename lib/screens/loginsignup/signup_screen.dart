import 'package:cloud_firestore/cloud_firestore.dart';
import '../../screenbarrel/screen_barrel.dart';

class SignUpScreen extends StatefulWidget {
  static const id = 'signupscreen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController = TextEditingController();
  final ConstSnackbar snackbar =ConstSnackbar();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [ColorManager.darkGreen, ColorManager.lightGreen],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 120, right: 20).r,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  UserDataTextFormField(
                    controller: _usernameTextController,
                    label: 'username',
                    icon: Icons.email_outlined,
                    isPasswordType: false,
                    hintText: 'Enter UserName',
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 15.h,
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
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  UserDataTextFormField(
                    controller: _confirmPasswordTextController,
                    label: 'confirm password',
                    icon: Icons.lock_outline,
                    isPasswordType: true,
                    hintText: 'Enter Confirm Password',
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  FormSubmitButton(buttonText:  "SIGN UP",onSubmitForm: ()=>submitSignupForm()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  submitSignupForm(){
    {
      if (_formKey.currentState!.validate()) {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text)
            .then((value) {
          print('Account created successfully');
          final auth = FirebaseAuth.instance.currentUser;
          auth!.updateDisplayName(_usernameTextController.text);
          FirebaseFirestore.instance
              .collection('Users')
              .doc(value.user!.email)
              .set({'Email': auth.email, 'Uid': auth.uid});
          Get.toNamed(ShoppingList.id);
          snackbar.successSnackbar();
        }).onError((error, stackTrace) =>snackbar.failedSnackbar(error.toString()));
      }
    }
  }
}
