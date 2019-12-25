import 'package:flutter/foundation.dart' as foundation;

double _salesTaxRate = 0.06;
double _shippingCostPerItem = 7;

class AppStateModel extends foundation.ChangeNotifier {
  // All the available products.
  String uid;

  String getUid() {
    return this.uid;
  }

  String addUid(String uid) {
    this.uid = uid;
  }
}
