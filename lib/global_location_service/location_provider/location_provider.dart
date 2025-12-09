import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class LocationProvider with ChangeNotifier {
  String? _selectedAreaName;
  int? _selectedAreaId;
  int? _selectedDynamicAddressId;
  String? get selectedAreaName => _selectedAreaName;
  int? get selectedAreaId => _selectedAreaId;
  int? get selectedDynamicAddressId => _selectedDynamicAddressId;
  Box get _box => Hive.box("LocationBox");
  final Uuid _uuid = const Uuid();


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

  Future<void> addLocation(Map<String, dynamic> newLocation) async {
    final stored = _box.get('location_list', defaultValue: []);
    final locations = List<Map<String, dynamic>>.from((stored as List).map((e) => Map<String, dynamic>.from(e)));

    // নতুন লোকেশনে ইউনিক আইডি যোগ করুন
    final newLoc = Map<String, dynamic>.from(newLocation);
    if (!newLoc.containsKey('id')) {
      newLoc['id'] = _uuid.v4(); // ইউনিক আইডি জেনারেট
    }

    // যদি একই টাইটেলের লোকেশন থাকে তাহলে পুরনোটা রিমুভ করুন
    final String newTitle = newLoc['title'] ?? 'Home';
    locations.removeWhere((loc) => loc['title'] == newTitle);

    locations.add(newLoc);
    await _box.put('location_list', locations);

    // নতুন যোগ করা লোকেশনটিকে সিলেক্ট করুন
    final newIndex = locations.indexWhere((loc) => loc['id'] == newLoc['id']);
    if (newIndex != -1) {
      await userSelectDynamicLocation(id: newIndex);
    }

    notifyListeners();
  }

  List<Map<String, dynamic>> get allLocations {
    final stored = _box.get('location_list', defaultValue: []);
    return List<Map<String, dynamic>>.from((stored as List).map((e) => Map<String, dynamic>.from(e)));
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


  Map<String, dynamic>? get selectedLocation {
    if (_selectedDynamicAddressId != null && _selectedDynamicAddressId! < allLocations.length) {return allLocations[_selectedDynamicAddressId!];}
    return null;
  }

}
