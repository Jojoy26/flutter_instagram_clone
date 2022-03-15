import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SecureStorageController extends GetxController {

  final FlutterSecureStorage storage;
  SecureStorageController({
    required this.storage,
  });

  Future save(String token) async{
    await storage.write(key: "token", value: token);
  }

  Future read() async {
    final result = await storage.read(key: "token");
    return result;
  }

  Future delete() async {
    await storage.delete(key: "token");
  }

}
