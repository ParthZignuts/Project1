import '../screenbarrel/screen_barrel.dart';
class UserDataTextFormField extends StatelessWidget {
  String hintText;
  IconData icon;
  bool isPasswordType;
  TextEditingController controller;
  String label;
  TextInputAction textInputAction;

 UserDataTextFormField({required this.hintText,required this.icon,required this.controller,required this.label,required this.isPasswordType,required this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textInputAction: textInputAction,
        controller: controller,
        obscureText: isPasswordType,
        cursorColor: ColorManager.white,
        style: TextStyle(color: ColorManager.white.withOpacity(0.9)),
        validator: (value) {
          if (label == "password" || label == "confirm password") {
            if (value == null || value.isEmpty) {
              return 'Please enter text';
            } else if (value.length < 8) {
              return 'Please enter more than 8 characters';
            }
          } else if (label == "email") {
            if (value == null || value.isEmpty) {
              return 'Please enter text';
            } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}')
                .hasMatch(value)) {
              return 'Please enter a valid email address';
            }
          } else {
            if (value == null || value.isEmpty) {
              return 'Please enter text';
            }
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white70,
          ),
          errorStyle: TextStyle(fontSize: 12.sp, color: ColorManager.red),
          hintText: hintText,
          hintStyle: TextStyle(color: ColorManager.white.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: ColorManager.white.withOpacity(0.3),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25).w,
              borderSide: BorderSide(width: 0.w, style: BorderStyle.none)),
        ));
  }
}
