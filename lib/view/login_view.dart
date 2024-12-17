import 'package:flutter/material.dart';
import 'package:mvvm_model/resources/components/round_button.dart';
import 'package:mvvm_model/utils/routes/routes_name.dart';
import 'package:mvvm_model/view/home_screen.dart';
import 'package:mvvm_model/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
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
    final height = MediaQuery.of(context).size.height*1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Login',style: TextStyle(color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                prefixIcon: Icon(Icons.alternate_email)
              ),
              onFieldSubmitted: (value){
                // FocusScope.of(context).requestFocus(passwordFocusNode);
                Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
              },

            ),
            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context,value,child){
                  return TextFormField(
                    controller: _passwordController,
                    focusNode: passwordFocusNode,
                    obscureText: _obsecurePassword.value,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_open_rounded),
                        suffixIcon: InkWell(
                            onTap: (){
                              _obsecurePassword.value =! _obsecurePassword.value;
                            },
                            child: Icon( _obsecurePassword.value ? Icons.visibility_off_outlined :
                                Icons.visibility
                            )),

                    ),

                  );
                }),
            SizedBox(height: height*0.085,),
            RoundButton(
              title: 'Login',
              loading: authViewModel.loading,
              onPress: (){
                if(_emailController.text.isEmpty){
                  Utils.flushBarErrorMessage('Please Enter Email', context);
                }else if(_passwordController.text.isEmpty){
                  Utils.flushBarErrorMessage('Please Enter Password', context);
                }else if(_passwordController.text.length <6){
                  Utils.flushBarErrorMessage('Please Enter 6 Digit Password', context);
                }else{
                //   Map data = {
                //     'email' : _emailController.text.toString(),
                //   'password' : _passwordController.text.toString(),
                // };
                  Map data = {
                    'email' : 'eve.holt@reqres.in',
                    'password' : 'cityslicka',
                  };

                  authViewModel.loginApi(data , context);
                  Utils.flushBarErrorMessage('Api Hit', context);
                }
              },
            ),
            SizedBox(height: height*0.02,),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, RoutesName.signUp);
              },
                child: Text('Dont have an account?Signup Please')),

          ],
        ),
      )
    );
  }
}
