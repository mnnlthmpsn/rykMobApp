import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/events/customer_event.dart';
import 'package:royalkitchen/models/customer_model.dart';
import 'package:royalkitchen/repos/customer_repo.dart';
import 'package:royalkitchen/states/form_submission_status.dart';
import 'package:royalkitchen/states/customer_state.dart';
import 'package:royalkitchen/utils/helpers.js.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository customerRepo;

  CustomerBloc({required this.customerRepo}) : super(CustomerState()) {
    on<FirstnameChanged>((event, emit) async {
      emit(state.copyWith(firstname: event.firstname));
    });

    on<OthernamesChanged>((event, emit) async {
      emit(state.copyWith(otherNames: event.otherNames));
    });

    on<EmailChanged>((event, emit) async {
      emit(state.copyWith(email: event.email));
    });

    on<PhoneChanged>((event, emit) async {
      emit(state.copyWith(phone: event.phone));
    });

    on<LocationChanged>((event, emit) async {
      emit(state.copyWith(location: event.location));
    });

    on<GetCustomerFromSharedPreferences>((event, emit) async {
      Customer customer = await getCustomerFromLocalStorage();

      emit(state.copyWith(
          id: customer.id.toString(),
          email: customer.email,
          firstname: customer.firstname,
          otherNames: customer.otherNames,
          phone: customer.phone
      ));
    });

    on<RegisterSubmitted>((event, emit) async {
      dynamic payload = {
        'data': {
          'email': state.email,
          'firstname': state.firstname,
          'other_names': state.otherNames,
          'phone': state.phone,
          'location': 'def_loc'
        }
      };

      //set is loading
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await customerRepo.addCustomer(payload);
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        print(e);
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
      } finally {
        emit(state.copyWith(formStatus: const InitialFormStatus()));
      }
    });
  }
}
