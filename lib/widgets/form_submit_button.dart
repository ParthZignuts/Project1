import '../screenbarrel/screen_barrel.dart';

class FormSubmitButton extends StatelessWidget {
  final String _buttonText;
  final Function _onSubmitForm;
   const FormSubmitButton({super.key, required String buttonText, required Function onSubmitForm}) : _onSubmitForm = onSubmitForm, _buttonText = buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45.h,
      margin: const EdgeInsets.only(top: 10,bottom: 20).r,
      child: ElevatedButton(
        onPressed: () {
          _onSubmitForm();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.white,
            foregroundColor: ColorManager.black2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30).w)
        ),
        child: Text(
          _buttonText,
          style:TextStyle(
            color: ColorManager.black2,
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
