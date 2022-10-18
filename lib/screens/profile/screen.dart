import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/define.dart';
import 'package:shop/ui/back.dart';
import 'package:shop/ui/cart.dart';
import 'package:shop/ui/search.dart';

class _ProfileViewModel {
  final bool isAuth;

  _ProfileViewModel({
    required this.isAuth,
  });

  static _ProfileViewModel fromState(Store<AppState> store) => _ProfileViewModel(
        isAuth: store.state.profile['is_auth'] ?? false,
      );
}

class ScreenProfile extends StatelessWidget {
  AppBar _crateBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: BackWidget(),
      actions: <Widget>[
        WidgetSearch(),
        WidgetCart(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ProfileViewModel>(
      converter: _ProfileViewModel.fromState,
      builder: (context, _ProfileViewModel vm) {
        return Scaffold(
          primary: true,
          backgroundColor: Color(0xFFF6F6F6),
          body: _createContent(context, vm),
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  Widget _createContent(context, _ProfileViewModel vm) {
    return Center(
      child: Container(
        // padding: EdgeInsets.all(25.0),
        margin: EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 3,
        ),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Login"),
              Container(
                padding: EdgeInsets.only(top: kDefaultPadding),
                child: CustomTextFormField(
                  label: 'Email',
                  keyboard: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is required and can\'t be empty';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: kDefaultPadding),
                child: CustomTextFormField(
                  label: 'Password',
                  keyboard: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || (value.runtimeType == String && value.trim().isEmpty)) {
                      return 'Password is required';
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: kDefaultPadding / 1.5,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 30),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: kPrimaryColor,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 1.5,
                      vertical: kDefaultPadding / 1.5,
                    ),
                  ),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Data'),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                ),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text("Forgot password"),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: Text("Create account"),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final TextInputType? keyboard;
  final FormFieldValidator<String>? validator;

  CustomTextFormField({
    Key? key,
    required this.label,
    required this.keyboard,
    required this.validator,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool hasError = false;
  Color _fieldColor = Colors.grey;

  final Color _highColor = kPrimaryColor;
  final Color _lowColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    var _viewColor = _fieldColor;
    if (true == hasError) {
      _viewColor = Colors.red;
    }

    return Focus(
      onFocusChange: (hasFocus) {
        setState(() => _fieldColor = hasFocus ? _highColor : _lowColor);
      },
      child: TextFormField(
        keyboardType: widget.keyboard,
        obscureText: widget.keyboard == TextInputType.visiblePassword,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: _viewColor,
          ),
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white70,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _fieldColor,
            ),
          ),
        ),
        validator: (value) {
          if (widget.validator != null) {
            String? valid = widget.validator?.call(value);

            setState(() => hasError = null != valid);

            return valid;
          }

          return null;
        },
      ),
    );
  }
}
