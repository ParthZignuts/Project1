import 'package:http/http.dart' as http;
import '../../screenbarrel/screen_barrel.dart';

class CocktailController extends GetxController{

  var cocktail=<RequestCocktailDataModel>[].obs;

  Future<List<RequestCocktailDataModel>> getCocktailData(String id) async{
    try {
      final response = await http.get(Uri.parse('${ApiUrl.baseURL}' '?s=$id'));
      var cocktailData =jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        print(jsonDecode(response.body.toString()));
        cocktail= RequestCocktailDataModel.fromJson(cocktailData) as RxList<RequestCocktailDataModel>;
      }
      return cocktail;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}