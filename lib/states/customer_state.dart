import 'package:royalkitchen/states/form_submission_status.dart';

class CustomerState {
  final String? id;
  final String firstname;
  final String otherNames;
  final String email;
  final String phone;
  final String location;
  final FormSubmissionStatus formStatus;

  CustomerState(
      {
        this.id,
        this.firstname = '',
      this.otherNames = '',
      this.email = '',
      this.phone = '',
      this.location = '',
      this.formStatus = const InitialFormStatus()});

  CustomerState copyWith(
      {
        String? id,
        String? firstname,
      String? otherNames,
      String? email,
      String? phone,
      String? location,
      FormSubmissionStatus? formStatus}) {
    return CustomerState(
      id: id ?? this.id,
        firstname: firstname ?? this.firstname,
        otherNames: otherNames ?? this.otherNames,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        location: location ?? this.location,
        formStatus: formStatus ?? this.formStatus);
  }
}
