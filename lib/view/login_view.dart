import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_practices/resources/components/round_button.dart';
import 'package:mvvm_practices/utils/routes/routes_names.dart';
import 'package:mvvm_practices/utils/utils.dart';
import 'package:mvvm_practices/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen',style: TextStyle(color: Colors.white,fontSize: 30),),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                focusNode: emailFocusNode,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email_rounded)
                ),
                onSubmitted: (value) {
                  Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                },
              ),
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context,value,child){
                    return TextField(
                        controller: _passwordController,
                        focusNode: passwordFocusNode,
                        obscureText: _obsecurePassword.value,
                        obscuringCharacter: "*",
                        decoration:  InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_open_rounded),
                            suffixIcon: InkWell(
                                onTap: (){
                                  _obsecurePassword.value = !_obsecurePassword.value;
                                },
                                child: _obsecurePassword.value ? const Icon(Icons.visibility_off_rounded) : const Icon(Icons.visibility))
                        ),
                      );
                  }),
               SizedBox(height: height * 0.1,),
              RoundButton(
                title: 'Login',
                loading: authViewModel.loading,
                onPress: () {
                  if(_emailController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter email', context);
                  }else if(_passwordController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter password', context);
                  }else if(_passwordController.text.length < 6){
                    Utils.flushBarErrorMessage('Please enter 6 digit password', context);
                  }else{
                    if (kDebugMode) {
                      print('Api Hit');
                      Map data = {
                        "email" : _emailController.text.toString(),
                        "password" : _passwordController.text.toString()
                      };
                      authViewModel.loginApi(data,context);
                    }
                  }
                },
              ),
              SizedBox(height: height * 0.05,),
              InkWell(
              onTap: (){
                Navigator.pushNamed(context, RoutesName.signUp);
              },
                  child: const Text("Don't have an account? Sign Up"))
            ],
          ),
        ),
      )
    );
  }
}
