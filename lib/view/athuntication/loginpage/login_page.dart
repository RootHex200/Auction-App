import 'package:ebay/controller/auth_controller.dart';
import 'package:ebay/view/athuntication/loginpage/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  final AuthController _authController=Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController paswordController;
  void initState() {
    emailController = TextEditingController();
    paswordController = TextEditingController();
    super.initState();
  }

  void dispose() {
    emailController.dispose();
    paswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                            height:250,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                
                )
              ),
              child: Center(
                  child: InkWell(
                onTap: () async {},
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
              )),
            ),
            const SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == "") {
                            return "Required";
                          } else if (value?.indexOf("@") == -1) {
                            return "Enter email address @ require";
                          }
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_add),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  style: BorderStyle.none,
                                )),
                            labelText: "Enter Email",
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == "") {
                            return "Required";
                          } else if (value!.length < 6) {
                            return "Password should be atleast 6 characters";
                          } else if (value.length > 15) {
                            return "Password should not be greater than 15 characters";
                          } else {
                            return null;
                          }
                        },
                        controller: paswordController,
                        keyboardType: TextInputType.visiblePassword,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  style: BorderStyle.none,
                                )),
                            labelText: "Enter Password",
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  _authController.user_sign_in(emailController.text, paswordController.text);
                }
              },
              child: Container(
                height: 50,
                width: double.maxFinite,
                margin: const EdgeInsets.only(left: 30, right: 30),
                decoration:  BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                    child: Text(
                  "Login",
                  style: TextStyle(fontSize: 23,color: Colors.white),
                )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Registration_page()));
                      },
                      child: const Text(
                        "Registrations now?",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
