import 'package:flutter/foundation.dart';

class KeranjangProvider extends ChangeNotifier {
  int _jumlah = 14; // Dari badge di HTML

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