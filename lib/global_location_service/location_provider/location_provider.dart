import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LocationProvider with ChangeNotifier {
  String? _selectedAreaName;
  int? _selectedAreaId;
  int? _selectedDynamicAddressId;
  String? get selectedAreaName => _selectedAreaName;
  int? get selectedAreaId => _selectedAreaId;
  int? get selectedDynamicAddressId => _selectedDynamicAddressId;
  Box get _box => Hive.box("LocationBox");



  LocationProvider(){
    loadSelectedAreaFromHive();
  }


  Future<void> setSelectedArea({required String name, required int id}) async {
    _selectedAreaName = name;
    _selectedAreaId = id;
    await saveSelectedAreaToHive(name: name, id: id);
    notifyListeners();
  }


  Future<void> saveSelectedAreaToHive({required String name, required int id}) async {
    await _box.put('selected_area_name', name);
    await _box.put('selected_area_id', id.toString());
  }


  Future<void> loadSelectedAreaFromHive() async {
    final name = _box.get('selected_area_name');
    final idString = _box.get('selected_area_id');
    final id = idString != null ? int.tryParse(idString) : null;

    if (name != null && id != null) {
      _selectedAreaName = name;
      _selectedAreaId = id;
      notifyListeners();
    }
  }


  /// >>> First Time Check And Set Permission Flag
  bool get isFirstTime => _box.get('check_hive', defaultValue: true);
  String get permissionFlag => _box.get('permission_flag', defaultValue: 'denied');
  Map<String,dynamic> get locationMap => Map<String,dynamic>.from(_box.get('location_map', defaultValue: {}));

  Future<void> setFirstTime(bool value) async {
    await _box.put('check_hive', value);
    notifyListeners();
  }

  Future<void> setPermissionFlag(String flag) async {
    await _box.put('permission_flag', flag);
    notifyListeners();
  }


  /// >>> Locations List Management ============================================

  Future<void> userSelectDynamicLocation({required int id}) async {
    _selectedDynamicAddressId = id;
    await _box.put('selected_id', id.toString());
    notifyListeners();
  }

  List<Map<String, dynamic>> get allLocations {
    final stored = _box.get('location_list', defaultValue: []);
    return List<Map<String, dynamic>>.from((stored as List).map((e) => Map<String, dynamic>.from(e)));
  }

  Future<void> addLocation(Map<String, dynamic> newLocation) async {
    final stored = _box.get('location_list', defaultValue: []);
    final locations = List<Map<String, dynamic>>.from((stored as List).map((e) => Map<String, dynamic>.from(e)));
    locations.add(newLocation);
    await _box.put('location_list', locations);
    notifyListeners();
  }

  Future<void> deleteLocation(int index) async {
    final stored = _box.get('location_list', defaultValue: []);
    final locations = List<Map<String, dynamic>>.from((stored as List).map((e) => Map<String, dynamic>.from(e)));
    if (locations.length <= 1) {return;}
    if (index >= 0 && index < locations.length) {
      locations.removeAt(index);
      await _box.put('location_list', locations);
      notifyListeners();
    }
  }


  Future<void> updateLocation(int index, Map<String, dynamic> updatedLocation) async {
    final stored = _box.get('location_list', defaultValue: []);
    final locations = List<Map<String, dynamic>>.from((stored as List).map((e) => Map<String, dynamic>.from(e)));
    if (index >= 0 && index < locations.length) {
      locations[index] = updatedLocation;
      await _box.put('location_list', locations);
      notifyListeners();
    }
  }


}
