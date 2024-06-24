import 'package:celest/celest.dart';

@cloud
Future<String> sayHello(String name) async {
  return 'Hello, $name!';
}
