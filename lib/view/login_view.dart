import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view/home_screen.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
            title: Text('Login'),
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
                  title: 'Login',
                  loading: authViewModel.loading,
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
                        'password': "cityslicka"
                      };
                      authViewModel.loginApi(data, context);
                      print('api hit');
                    }
                  }),
              SizedBox(height: height * .02,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.signUp);
                },
                child: Text("Don't have an account? SignUp")
              ),
            ],
          )),
    );
  }
}
