import 'package:royalkitchen/models/customer_model.dart';

abstract class CustomerEvent {}

class FirstnameChanged extends CustomerEvent {
  final String firstname;

  FirstnameChanged({ required this.firstname });
}

class OthernamesChanged extends CustomerEvent {
  final String otherNames;

  OthernamesChanged({ required this.otherNames });
}

class EmailChanged extends CustomerEvent {
  final String email;

  EmailChanged({ required this.email });
}

class PhoneChanged extends CustomerEvent {
  final String phone;

  PhoneChanged({ required this.phone });
}

class LocationChanged extends CustomerEvent {
  final String location;

  LocationChanged({ required this.location });
}

class StoreCustomerInSharedPreferences extends CustomerEvent {
  final Customer customer;

  StoreCustomerInSharedPreferences({ required this.customer });
}

class GetCustomerFromSharedPreferences extends CustomerEvent {}

class RegisterSubmitted extends CustomerEvent {}