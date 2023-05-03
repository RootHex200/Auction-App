import 'package:ebay/controller/auth_controller.dart';
import 'package:ebay/controller/obscuretext_controller.dart';
import 'package:ebay/utils/colors.dart';
import 'package:ebay/view/Authenticationpage/registrationpage/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  final AuthController _authController = Get.put(AuthController());
  final ObscureTextController obscureTextController =
      Get.put(ObscureTextController());
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController paswordController;
  @override
  void initState() {
    emailController = TextEditingController();
    paswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    paswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Image(
                      width: MediaQuery.of(context).size.width,
                      image: const AssetImage("assets/images/login.png"),
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Welcome",
                              style: TextStyle(
                                  color: Appcolors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500)),
                          Text("Back",
                              style: TextStyle(
                                  color: Appcolors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
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
                            return null;
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
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Appcolors.primaryColor)),
                              labelText: "Enter Email",
                              labelStyle: const TextStyle(
                                color: Appcolors.textSecondaryColor,
                                fontSize: 20,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => TextFormField(
                            obscureText:
                                obscureTextController.loginObscureText.value,
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
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      obscureTextController
                                          .loginObscureTextChange();
                                    },
                                    child: obscureTextController
                                            .loginObscureText.value
                                        ? const Icon(
                                            Icons.visibility,
                                            color: Appcolors.grey,
                                          )
                                        : const Icon(
                                            Icons.visibility_off,
                                            color: Appcolors.grey,
                                          )),
                                prefixIcon: const Icon(Icons.password),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      style: BorderStyle.none,
                                    )),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Appcolors.primaryColor)),
                                labelText: "Enter Password",
                                labelStyle: const TextStyle(
                                  color: Appcolors.textSecondaryColor,
                                  fontSize: 20,
                                )),
                          ),
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
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    _authController.user_sign_in(
                        emailController.text, paswordController.text);
                  }
                },
                child: Container(
                  height: 50,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  decoration: BoxDecoration(
                    color: Appcolors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                      child: Text(
                    "SIGN IN",
                    style: TextStyle(fontSize: 23, color: Appcolors.white),
                  )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Registration_page()));
                    },
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "Don't Have an acccount?",
                          style: TextStyle(
                              fontSize: 16,
                              color: Appcolors.textSecondaryColor)),
                      TextSpan(
                          text: "SIGN UP",
                          style: TextStyle(
                              color: Appcolors.secondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))
                    ])),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
