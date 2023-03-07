import '../screenbarrel/screen_barrel.dart';
class TitleTextWidget extends StatelessWidget {
  final String _titleText;
   const TitleTextWidget({Key? key,required String titleText}) : _titleText = titleText, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _titleText,
      style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          color:ColorManager.white
      ),
    );
  }
}
