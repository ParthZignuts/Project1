
import 'package:http/http.dart' as http;
import '../../../screenbarrel/screen_barrel.dart';

class CocktailViewScreen extends StatefulWidget {
  static const id = "cocktailScreen";

  const CocktailViewScreen({Key? key}) : super(key: key);

  @override
  State<CocktailViewScreen> createState() => _CocktailViewScreenState();
}

class _CocktailViewScreenState extends State<CocktailViewScreen> {

    String _endPointUrl = "margarita";


  // Update the endpointUrl value and rebuild the widget
  void updateEndpointUrl(String newUrl) {
    setState(() {
      _endPointUrl = newUrl;
    });
  }

  //fetch Data from API
  Future<RequestCocktailDataModel> getCocktailData(String id) async {
    try {
      final response = await http.get(Uri.parse('${ApiUrl.baseURL}' '?s=$id'));
      var cocktailData =jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        print(jsonDecode(response.body.toString()));
        return RequestCocktailDataModel.fromJson(cocktailData);
      } else {
        return RequestCocktailDataModel.fromJson(cocktailData);
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController cocktailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Cocktails'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: cocktailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                    icon: const Icon(Icons.keyboard_arrow_right),
                    onPressed: () {
                      setState(() {
                        _endPointUrl = cocktailController.text;
                      });
                    }),
                filled: true,
                hintText: 'Enter Cocktail Name',
                label: const Text('Cocktail'),
              ),
            ),
          ),
          Expanded(
            child:FutureBuilder<RequestCocktailDataModel>(
              future: getCocktailData(_endPointUrl),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child:  CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.drinks == null
                        ? 0
                        : snapshot.data?.drinks!.length,
                    itemBuilder: (context, index) {
                      print(snapshot.data!.drinks![index].strDrink);
                      return GestureDetector(
                        onTap: (){
                          Get.bottomSheet(Container(
                          height: 500,
                            child:   CocktailImageUrlText(cocktailUrlText: snapshot.data!.drinks![index].strDrinkThumb.toString()),
                          ));
                        },
                        child: Card(
                          shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 10,
                          color: ColorManager.lemonGreen,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CocktailImageUrlText(
                                  cocktailUrlText: snapshot.data!.drinks![index].strDrinkThumb.toString()),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${snapshot.data!.drinks![index].strDrink}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.lightGreen),
                                      ),
                                      CocktailDescriptionText(
                                          cocktailDescText: snapshot.data!.drinks![index].strInstructions.toString())
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
