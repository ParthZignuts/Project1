import '../screenbarrel/screen_barrel.dart';
class CocktailDescriptionText extends StatelessWidget {
  final String _cocktailDescText;
   const CocktailDescriptionText({Key? key,required String cocktailDescText}) : _cocktailDescText = cocktailDescText, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _cocktailDescText,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
    );
  }
}
