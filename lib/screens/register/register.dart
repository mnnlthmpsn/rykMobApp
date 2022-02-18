import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/customer_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/events/customer_event.dart';
import 'package:royalkitchen/states/customer_state.dart';
import 'package:royalkitchen/states/form_submission_status.dart';
import 'package:royalkitchen/utils/helpers.js.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  void _setFirstTime() => storeInLocalStorage('first_time', false, 'bool');

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _registerForm(context),
      ),
    );
  }

  Widget _registerHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 30),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text('Before we continue...',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('We want to know you', style: TextStyle(fontSize: 14))
          ],
        ),
      ),
    );
  }

  Widget _registerForm(context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 80.0, right: 20, left: 20, bottom: 10),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: <Widget>[
              _registerHeader(),
              _firstname(),
              const SizedBox(height: 10),
              _otherNames(),
              const SizedBox(height: 10),
              _email(),
              const SizedBox(height: 10),
              _phone(),
              const SizedBox(height: 15),
              _registerBtn()
            ],
          ),
        ));
  }

  Widget _firstname() {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textAlignVertical: TextAlignVertical.top,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field is required';
            }
            return null;
          },
          onChanged: (value) => context
              .read<CustomerBloc>()
              .add(FirstnameChanged(firstname: value)),
          cursorColor: KColors.kTextColorDark,
          style: const TextStyle(color: KColors.kTextColorDark, fontSize: 16),
          decoration: const InputDecoration(
              labelText: 'Firstname',
              labelStyle: TextStyle(fontSize: 16),
              prefixIcon: Icon(
                Icons.person_add_alt_1_sharp,
                size: 16,
              )),
        );
      },
    );
  }

  Widget _otherNames() {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (BuildContext context, CustomerState state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          textAlignVertical: TextAlignVertical.top,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field is required';
            }
            return null;
          },
          onChanged: (value) => context
              .read<CustomerBloc>()
              .add(OthernamesChanged(otherNames: value)),
          cursorColor: KColors.kTextColorDark,
          style: const TextStyle(color: KColors.kTextColorDark, fontSize: 16),
          decoration: const InputDecoration(
              labelStyle: TextStyle(fontSize: 16),
              labelText: 'Other Names',
              prefixIcon: Icon(Icons.person, size: 16)),
        );
      },
    );
  }

  Widget _email() {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (BuildContext context, CustomerState state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          textAlignVertical: TextAlignVertical.top,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field is required';
            }
            if (value.isNotEmpty && isEmail(value) == false) {
              return 'Check your email';
            }

            return null;
          },
          onChanged: (value) =>
              context.read<CustomerBloc>().add(EmailChanged(email: value)),
          cursorColor: KColors.kTextColorDark,
          style: const TextStyle(color: KColors.kTextColorDark, fontSize: 16),
          decoration: const InputDecoration(
              labelStyle: TextStyle(fontSize: 16),
              labelText: 'Email',
              prefixIcon: Icon(Icons.attach_email_outlined, size: 16)),
        );
      },
    );
  }

  Widget _phone() {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (BuildContext context, CustomerState state) {
        return TextFormField(
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          textAlignVertical: TextAlignVertical.top,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field is required';
            }

            if (value.isNotEmpty && value.length < 10) {
              return 'Phone has to be 10 digits';
            }

            return null;
          },
          onChanged: (value) =>
              context.read<CustomerBloc>().add(PhoneChanged(phone: value)),
          cursorColor: KColors.kTextColorDark,
          style: const TextStyle(color: KColors.kTextColorDark, fontSize: 16),
          decoration: const InputDecoration(
              labelStyle: TextStyle(fontSize: 16),
              labelText: 'Phone',
              prefixIcon: Icon(Icons.phone_iphone_outlined, size: 16)),
        );
      },
    );
  }

  Widget _registerBtn() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: (BlocConsumer<CustomerBloc, CustomerState>(
        builder: (BuildContext context, CustomerState state) {
          return ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<CustomerBloc>().add(RegisterSubmitted());
              }
            },
            child: Text(
                state.formStatus is FormSubmitting ? 'loading...' : 'Continue',
                style: const TextStyle(fontSize: 14, color: Colors.white)),
          );
        },
        listener: (BuildContext context, CustomerState state) {
          if (state.formStatus is SubmissionSuccess) {
            // set first time to false
            _setFirstTime();

            // navigate to home
            newPageDestroyPrevious(context, 'home');
          }
          if (state.formStatus is SubmissionFailed) {
            BotToast.showText(
                text: 'Sorry an error occured',
                textStyle: TextStyle(fontSize: 14, color: Colors.white));
          }
        },
      )),
    );
  }
}
