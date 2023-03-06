import '../screenbarrel/screen_barrel.dart';
class TitleTextWidget extends StatelessWidget {
  String titleText;
   TitleTextWidget({Key? key,required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          color:ColorManager.white
      ),
    );
  }
}
