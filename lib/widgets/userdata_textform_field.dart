import '../screenbarrel/screen_barrel.dart';
class UserDataTextFormField extends StatelessWidget {
  final String _hintText;
  final IconData _icon;
  final bool _isPasswordType;
  final TextEditingController _controller;
  final String _label;
  final TextInputAction _textInputAction;

 const UserDataTextFormField({super.key, required String hintText,required IconData icon,required TextEditingController controller,required String label,required bool isPasswordType,required TextInputAction textInputAction}) : _textInputAction = textInputAction, _label = label, _controller = controller, _isPasswordType = isPasswordType, _icon = icon, _hintText = hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textInputAction: _textInputAction,
        controller: _controller,
        obscureText: _isPasswordType,
        cursorColor: ColorManager.white,
        style: TextStyle(color: ColorManager.white.withOpacity(0.9)),
        validator: (value) {
          if (_label == "password" || _label == "confirm password") {
            if (value == null || value.isEmpty) {
              return 'Please enter text';
            } else if (value.length < 8) {
              return 'Please enter more than 8 characters';
            }
          } else if (_label == "email") {
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
            _icon,
            color: Colors.white70,
          ),
          errorStyle: TextStyle(fontSize: 12.sp, color: ColorManager.red),
          hintText: _hintText,
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
