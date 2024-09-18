import 'package:firebase_auth/firebase_auth.dart';

class MockUser implements User {
  @override
  String? get displayName => "Abigail";

  @override
  String? get email => "abigail@example.com";

  // Implemente os outros métodos/propriedades da classe User conforme necessário
  @override
  // Add other properties and methods of the User class with default values or mock data
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
