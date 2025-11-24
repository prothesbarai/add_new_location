import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
class HiveService {
  static Future<void> initHive() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await  Hive.openBox("LocationBox");
  }
}
