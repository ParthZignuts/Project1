import 'package:http/http.dart' as http;
import '../../screenbarrel/screen_barrel.dart';

class CocktailController extends GetxController {
  var cocktail = <RequestCocktailDataModel>[].obs;

  Future<List<RequestCocktailDataModel>> getCocktailData(String id) async {
    try {
      final response = await http.get(Uri.parse('${ApiUrl.baseURL}' '?s=$id'));
      var cocktailData = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        cocktail = RequestCocktailDataModel.fromJson(cocktailData)
            as RxList<RequestCocktailDataModel>;
      }
      return cocktail;
    } catch (e) {
      throw Get.snackbar(
          'Error',e.toString(),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP);
    }
  }
}
