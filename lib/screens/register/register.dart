import 'dart:convert';

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
      padding: const EdgeInsets.only(top: 10, bottom: 50),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text('One more thing...',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            Text('We want to know you', style: TextStyle(fontSize: 18))
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
              const SizedBox(height: 20),
              _otherNames(),
              const SizedBox(height: 20),
              _email(),
              const SizedBox(height: 20),
              _phone(),
              const SizedBox(height: 20),
              _location(),
              const SizedBox(height: 15),
              _registerBtn()
            ],
          ),
        ));
  }

  Widget _firstname() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (context, state) {
          return TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (value) => null,
            onChanged: (value) => context
                .read<CustomerBloc>()
                .add(FirstnameChanged(firstname: value)),
            cursorColor: KColors.kTextColorDark,
            style: const TextStyle(color: KColors.kTextColorDark, fontSize: 16),
            decoration: const InputDecoration(
                labelText: 'Firstname',
                labelStyle: TextStyle(fontSize: 16),
                prefixIcon: Icon(Icons.person_add_alt_1_sharp)),
          );
        },
      ),
    );
  }

  Widget _otherNames() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (BuildContext context, CustomerState state) {
          return TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) => null,
            onChanged: (value) => context
                .read<CustomerBloc>()
                .add(OthernamesChanged(otherNames: value)),
            cursorColor: KColors.kTextColorDark,
            style: const TextStyle(color: KColors.kTextColorDark, fontSize: 16),
            decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 16),
                labelText: 'Other Names',
                prefixIcon: Icon(Icons.person)),
          );
        },
      ),
    );
  }

  Widget _email() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (BuildContext context, CustomerState state) {
          return TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) => null,
            onChanged: (value) =>
                context.read<CustomerBloc>().add(EmailChanged(email: value)),
            cursorColor: KColors.kTextColorDark,
            style: const TextStyle(color: KColors.kTextColorDark, fontSize: 16),
            decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 16),
                labelText: 'Email',
                prefixIcon: Icon(Icons.attach_email_outlined)),
          );
        },
      ),
    );
  }

  Widget _phone() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (BuildContext context, CustomerState state) {
          return TextFormField(
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (value) => null,
            onChanged: (value) =>
                context.read<CustomerBloc>().add(PhoneChanged(phone: value)),
            cursorColor: KColors.kTextColorDark,
            style: const TextStyle(color: KColors.kTextColorDark, fontSize: 16),
            decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 16),
                labelText: 'Phone',
                prefixIcon: Icon(Icons.phone_iphone_outlined)),
          );
        },
      ),
    );
  }

  Widget _location() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (BuildContext context, CustomerState state) {
          return TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: (value) => null,
            onChanged: (value) => context
                .read<CustomerBloc>()
                .add(LocationChanged(location: value)),
            cursorColor: KColors.kTextColorDark,
            style: const TextStyle(color: KColors.kTextColorDark, fontSize: 16),
            decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 16),
                labelText: 'Location',
                prefixIcon: Icon(Icons.location_on_outlined)),
          );
        },
      ),
    );
  }

  Widget _registerBtn() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: (BlocConsumer<CustomerBloc, CustomerState>(
        builder: (BuildContext context, CustomerState state) {
          return ElevatedButton(
            onPressed: () =>
                context.read<CustomerBloc>().add(RegisterSubmitted()),
            child: Text(
                state.formStatus is FormSubmitting ? 'loading...' : 'Continue',
                style: const TextStyle(fontSize: 16, color: Colors.white)),
          );
        },
        listener: (BuildContext context, CustomerState state) {
          if (state.formStatus is SubmissionSuccess) {
            // set first time to false
            _setFirstTime();

            // navigate to home
            newPageDestroyPrevious(context, 'home');
          }
        },
      )),
    );
  }
}
