
import 'package:cares_task/core/features/auth/auth_controller.dart';
import 'package:cares_task/core/features/auth/singUp_screen.dart';
import 'package:cares_task/core/theme/color_scheme.dart';
import 'package:cares_task/core/utils/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool obscureText = true;
  String? email;
  String? password;
  bool rememberPassword = false;

  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  final authController = Get.put(AuthController());

  void loginValidator(){

    if (formKey.currentState!.validate()) {

     authController.loginUser(email.toString(), password.toString());

    }
  }

  @override
  void initState() {

    checkRememberPassword();
    super.initState();
  }

  final storage = GetStorage();

  void checkRememberPassword() {
    final saveEmail = storage.read("email");
    final savePass = storage.read("password");

    setState(() {
      if (saveEmail != null && savePass != null) {
        email = saveEmail;
        password = savePass;
        rememberPassword = true;
      } else {
        rememberPassword = false;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Scaffold(
         backgroundColor:colorScheme.surfaceVariant,
         body: SingleChildScrollView(
          child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
              height: 24,
              ),
              Align(
                alignment: Alignment.center,
                  child: Lottie.asset("assets/animation/login.json",width: 300, height: 200)),

              Text(
                "User Login",
                style: textTheme.titleMedium?.copyWith(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 30,
              ),

              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: TextFormField(
                        initialValue: email,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter Your email';
                          }
                          return null;
                        }, onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            fillColor: Colors.white38,
                             filled: true,
                             hintText: "Enter  email",
                            prefixIcon: Icon(FluentIcons.person_24_regular,color: Colors.black38)
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    Card(
                      child: TextFormField(
                        initialValue: password,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter Your Password';
                          }
                          return null;
                        }, onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                       },
                         decoration: InputDecoration(
                           fillColor: Colors.white38,
                           filled: true,
                          contentPadding: EdgeInsets.all(16),
                           hintText: "Enter Password",
                          prefixIcon: Icon(Icons.lock_outline_rounded,color: HexColor('#855EA9'),),
                          suffixIcon: IconButton(
                              icon: Icon(
                                obscureText ? Icons.visibility : Icons.visibility_off,
                                color: HexColor('#855EA9'),
                              ),
                              onPressed: togglePasswordVisibility),
                        ),

                        keyboardType: TextInputType.text,
                        obscureText: obscureText,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Expanded(
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                            onTap: () {
                              setState(() {
                                rememberPassword = !rememberPassword;
                              });
                            },
                            leading: Checkbox(
                              value: rememberPassword,
                              onChanged: (value) {
                                setState(() {
                                  rememberPassword = !rememberPassword;
                                });
                              },
                            ),
                            title:  Text("remember me".tr,style: textTheme.titleMedium?.copyWith(
                                color: Colors.black87,
                                 fontSize: 14,
                                fontWeight: FontWeight.bold)),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(
                      height: 16,
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          //foregroundColor: colorScheme.onPrimary,
                          backgroundColor:HexColor('#855EA9'),

                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                        onPressed: (){

                          loginValidator();
                        },
                        child: Text('Login',style: textTheme.bodyLarge?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lightColorScheme!.onPrimary)),
                      ),
                    ),

                    SizedBox(
                      height: 16,
                    ),

                    InkWell(
                     focusColor: Colors.black12,
                      onTap: (){
                        Get.off(SingUpScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "I Have Not Account !",
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ),
    ));
  }
}
