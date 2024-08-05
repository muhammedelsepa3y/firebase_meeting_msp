import 'package:firebase_meeting_msp/services/auth_service.dart';
import 'package:firebase_meeting_msp/services/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../register_screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("rebuild again!!!");
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                RegExp emailRegExp =
                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegExp.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Consumer<LoginProvider>(builder: (context, provider, _) {
              print("rebuild text form field");
              return Column(
                children: [
                  TextFormField(
                    controller: passwordController,
                    obscureText: !provider.isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffix: IconButton(
                          onPressed: () {
                            provider.togglePasswordVisibility();
                          },
                          icon: Icon(Icons.visibility_off)),
                    ),
                  ),
                  provider.isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: ()async {
                            if (formKey.currentState!.validate()) {
                              print('Validated');
                              provider.setLoading(true);
                              try{
                            await  AuthService().login(
                                emailController.text,
                                passwordController.text,
                              );}catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),));
                              }
                              provider.setLoading(false);

                            } else {
                              print('Not Validated');
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                  }, child: Text("register"))
                ],
              );
            }),
            // Consumer<AuthService>(
            //   builder: (context,provider,_) {
            //     print ("rebuild button");
            //     print ("provider.loading "+provider.loading.toString());
            //
            //  return Provider.of<AuthService>(context).loading==true?
            //
            //     }
            //
            // )
          ],
        ),
      ),
    ));
  }
}
