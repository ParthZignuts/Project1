import '../../../../screenbarrel/screen_barrel.dart';
class ResetPasswordScreen extends StatefulWidget {
  static const id="resetpasswordscreen";
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final TextEditingController _emailTextController = TextEditingController();
  final ConstSnackbar snackbar=ConstSnackbar();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:Text(
            'Reset Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:BoxDecoration(
              gradient: LinearGradient(colors: [
                ColorManager.lightGreen,
                ColorManager.green
              ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,top: 120,right: 20).r,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    UserDataTextFormField(controller: _emailTextController,label: 'email',icon: Icons.email_outlined,isPasswordType:false,hintText: 'Enter Email',textInputAction: TextInputAction.done,),
                    SizedBox(
                      height: 15.h,
                    ),
                    FormSubmitButton( buttonText: 'Reset Password', onSubmitForm: ()=>_submitResetPasswordForm()),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

   _submitResetPasswordForm(){
    {
      if(_formKey.currentState!.validate()) {
        FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text).then((value) {
         Get.toNamed(LoginScreen.id);
         snackbar.resetSuccessSnackbar();
        }).onError((error, stackTrace) => snackbar.failedSnackbar(error.toString()));
      }
    }
  }
}