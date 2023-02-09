import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
var getItPages = getIt<Pages>();
var getItCalculator = getIt<Calculator>();

void setup() {
  getIt.registerSingleton<Pages>(Pages());
  getIt.registerSingleton<Calculator>(Calculator());
}

class Pages {
  var urlPath = '/';
  var drawerOnUrl;
  var individual = true;

  setUrlPath(url) {
    urlPath = url;
    // notifyListeners();
  }
}

class Calculator extends ChangeNotifier {
  var country = 'France';
  var score = 0.0;
  var finalScore = 0.0;
  var apart = 0;

  setScore(value) {
    score = value;
    notifyListeners();
  }

  setFinalScore(value) {
    finalScore = value;
    notifyListeners();
  }
}
