import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../res/components/round_button.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  ValueNotifier _obsecurePassword = ValueNotifier(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('SignUp'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email)),
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(
                      context, emailFocusNode, passwordFocusNode);
                  //FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: _obsecurePassword.value,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: InkWell(
                              onTap: () {
                                _obsecurePassword.value =
                                !_obsecurePassword.value;
                              },
                              child: Icon(_obsecurePassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility))),
                    );
                  }),
              SizedBox(
                height: height * .085,
              ),
              RoundButton(
                  title: 'Sign Up',
                  loading: authViewModel.signUpLoading,
                  onPress: () {
                    if (_emailController.text.isEmpty) {
                      Utils.flushBarErrorMessage('Please enter email', context);
                    } else if (_passwordController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please enter password', context);
                    } else if (_passwordController.text.length < 2) {
                      Utils.flushBarErrorMessage('Please enter email', context);
                    } else {
                      Map data = {
                        //'email': _emailController.text.toString(),
                        //'password': _passwordController.text.toString()
                        'email': "eve.holt@reqres.in",
                        'password': "pistol"
                      };
                      authViewModel.signUpApi(data, context);
                      print('api hit');
                    }
                  }),
              SizedBox(height: height * .02,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.login);
                },
                child: Text("Already have an account? Lopgin")
              ),
            ],
          )),
    );
  }
}
