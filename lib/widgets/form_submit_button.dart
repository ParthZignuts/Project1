import '../screenbarrel/screen_barrel.dart';

class FormSubmitButton extends StatelessWidget {
  final String buttonText;
  final Function onSubmitForm;
   const FormSubmitButton({required this.buttonText, required this.onSubmitForm,Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45.h,
      margin: const EdgeInsets.only(top: 10,bottom: 20).r,
      child: ElevatedButton(
        onPressed: () {
          onSubmitForm();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.white,
            foregroundColor: ColorManager.black2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30).w)
        ),
        child: Text(
          buttonText,
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
