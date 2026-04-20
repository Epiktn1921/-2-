import 'package:uuid/uuid.dart';

class IdGenerator {
  static const _uuid = Uuid();
  
  static String generate() => _uuid.v4();
  
  static bool isValid(String id) => _uuid.isValid(id);
}
