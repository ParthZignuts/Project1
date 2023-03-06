
import '../screenbarrel/screen_barrel.dart';
class CocktailImageUrlText extends StatelessWidget {
  String cocktailUrlText;

  CocktailImageUrlText({Key? key, required this.cocktailUrlText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),

      ),
      child: Image.network(cocktailUrlText,fit: BoxFit.fill),
    );
  }
}

