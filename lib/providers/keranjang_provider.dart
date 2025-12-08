// lib/models/keranjang_model.dart
import 'package:flutter/foundation.dart';

class KeranjangProvider extends ChangeNotifier {
  int _jumlah = 14;

  int get jumlah => _jumlah;

  void tambah() {
    _jumlah++;
    notifyListeners();
  }

  void kurang() {
    if (_jumlah > 0) {
      _jumlah--;
      notifyListeners();
    }
  }
}