
import '../screenbarrel/screen_barrel.dart';
class CocktailImageUrlText extends StatelessWidget {
  final String _cocktailUrlText;

  const CocktailImageUrlText({Key? key, required String cocktailUrlText}) : _cocktailUrlText = cocktailUrlText, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),

      ),
      child: Image.network(_cocktailUrlText,fit: BoxFit.fill),
    );
  }
}

