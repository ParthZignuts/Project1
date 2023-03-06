

class RequestCocktailDataModel {
  List<Drinks>? _drinks;

  RequestCocktailDataModel({List<Drinks>? drinks}) {
    if (drinks != null) {
      _drinks = drinks;
    }
  }

  List<Drinks>? get drinks => _drinks;
  set drinks(List<Drinks>? drinks) => _drinks = drinks;

  RequestCocktailDataModel.fromJson(Map<String, dynamic> json) {
    if (json['drinks'] != null) {
      _drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        _drinks!.add( Drinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (_drinks != null) {
      data['drinks'] = _drinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Drinks {
  String? _idDrink;
  String? _strDrink;
  String? _strInstructions;
  String? _strDrinkThumb;

  Drinks(
      {String? idDrink,
        String? strDrink,
        String? strInstructions,
        String? strDrinkThumb,
     }) {
    if (idDrink != null) {
      this._idDrink = idDrink;
    }
    if (strDrink != null) {
      this._strDrink = strDrink;
    }

    if (strInstructions != null) {
      this._strInstructions = strInstructions;
    }

    if (strDrinkThumb != null) {
      this._strDrinkThumb = strDrinkThumb;
    }

  }

  String? get idDrink => _idDrink;
  set idDrink(String? idDrink) => _idDrink = idDrink;
  String? get strDrink => _strDrink;
  set strDrink(String? strDrink) => _strDrink = strDrink;

  String? get strInstructions => _strInstructions;
  set strInstructions(String? strInstructions) =>
      _strInstructions = strInstructions;
  String? get strDrinkThumb => _strDrinkThumb;
  set strDrinkThumb(String? strDrinkThumb) => _strDrinkThumb = strDrinkThumb;


  Drinks.fromJson(Map<String, dynamic> json) {
    _idDrink = json['idDrink'];
    _strDrink = json['strDrink'];

    _strInstructions = json['strInstructions'];
     _strDrinkThumb = json['strDrinkThumb'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idDrink'] = this._idDrink;
    data['strDrink'] = this._strDrink;
   data['strInstructions'] = this._strInstructions;
      data['strDrinkThumb'] = this._strDrinkThumb;

    return data;
  }
}
