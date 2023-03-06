import '../screenbarrel/screen_barrel.dart';
class CocktailDescriptionText extends StatelessWidget {
  String cocktailDescText;
   CocktailDescriptionText({Key? key,required this.cocktailDescText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      cocktailDescText,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
    );
  }
}
