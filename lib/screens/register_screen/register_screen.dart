import 'package:firebase_meeting_msp/screens/login_screen/login_screen.dart';
import 'package:firebase_meeting_msp/services/auth_service.dart';
import 'package:firebase_meeting_msp/services/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

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
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Name';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Age';
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
                              await  AuthService().register(
                                emailController.text,
                                passwordController.text,
                                nameController.text,
                                ageController.text,
                              );
                              provider.setLoading(false);
                              Navigator.pop(context);

                            }catch(e){
                              provider.setLoading(false);

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),));
                            }


                          } else {
                            print('Not Validated');
                          }
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      }, child: Text("login"))
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
