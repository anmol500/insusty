import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
var getItPages = getIt<Pages>();

void setup() {
  getIt.registerSingleton<Pages>(Pages());
}

class Pages extends ChangeNotifier {
  var urlPath = '/';
  var drawerOnUrl;

  setUrlPath(url) {
    urlPath = url;
    notifyListeners();
  }
}

class Calculator {
  var country = 'France';
}
