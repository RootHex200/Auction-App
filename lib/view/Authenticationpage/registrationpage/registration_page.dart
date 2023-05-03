import 'package:ebay/controller/auth_controller.dart';
import 'package:ebay/controller/obscuretext_controller.dart';
import 'package:ebay/utils/colors.dart';
import 'package:ebay/view/Authenticationpage/loginpage/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Registration_page extends StatefulWidget {
  const Registration_page({Key? key}) : super(key: key);

  @override
  State<Registration_page> createState() => _Registration_pageState();
}

class _Registration_pageState extends State<Registration_page> {
  final AuthController _authController = Get.put(AuthController());
  final ObscureTextController obscureTextController =
      Get.put(ObscureTextController());
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController paswordController;
  late TextEditingController confarmController;
  late TextEditingController phoneController;
  late TextEditingController usernameController;

  @override
  void initState() {
    emailController = TextEditingController();
    paswordController = TextEditingController();
    confarmController = TextEditingController();
    phoneController = TextEditingController();
    usernameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    paswordController.dispose();
    confarmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Login_page()));
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Appcolors.secondaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      const Image(
                          image: AssetImage("assets/images/signup.png")),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Create",
                                style: TextStyle(
                                    color: Appcolors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500)),
                            Text("Account",
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
                              }
                              return null;
                            },
                            controller: usernameController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color: Appcolors.white,
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Appcolors.grey,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      style: BorderStyle.none,
                                    )),
                                labelText: "Enter Username",
                                labelStyle: const TextStyle(
                                  color: Appcolors.white,
                                  fontSize: 20,
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == "") {
                                return "Required";
                              } else if (value?.indexOf("@") == -1) {
                                return "Enter email address @ require";
                              } else if (!value!.endsWith("gmail.com")) {
                                return "Enter valid email address";
                              }
                              return null;
                            },
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color: Appcolors.white,
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person_add,
                                  color: Appcolors.grey,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      style: BorderStyle.none,
                                    )),
                                labelText: "Enter Email",
                                labelStyle: const TextStyle(
                                  color: Appcolors.white,
                                  fontSize: 20,
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => TextFormField(
                              obscureText:
                                  obscureTextController.signupObscureText.value,
                              validator: (value) {
                                if (value == "") {
                                  return "Required";
                                } else if (value!.length < 6) {
                                  return "Password should be atleast 6 characters";
                                } else if (value.length > 15) {
                                  return "Password should not be greater than 15 characters";
                                }
                                return null;
                              },
                              controller: paswordController,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(
                                color: Appcolors.white,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      obscureTextController
                                          .signupObscureTextChange();
                                    },
                                    child: obscureTextController
                                            .signupObscureText.value
                                        ? const Icon(
                                            Icons.visibility,
                                            color: Appcolors.grey,
                                          )
                                        : const Icon(
                                            Icons.visibility_off,
                                            color: Appcolors.grey,
                                          ),
                                  ),
                                  prefixIcon: const Icon(Icons.password,
                                      color: Appcolors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        style: BorderStyle.none,
                                      )),
                                  labelText: "Enter Password",
                                  labelStyle: const TextStyle(
                                    color: Appcolors.white,
                                    fontSize: 20,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == "") {
                                return "Required";
                              } else if (value!.length < 11 ||
                                  value.length > 11) {
                                return "Password should be atleast 11 characters";
                              } else if (!value.startsWith("01")) {
                                return "Enter valid mobile number";
                              }
                              return null;
                            },
                            controller: phoneController,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(
                              color: Appcolors.white,
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Appcolors.grey,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      style: BorderStyle.none,
                                    )),
                                labelText: "Enter Mobile",
                                labelStyle: const TextStyle(
                                  color: Appcolors.white,
                                  fontSize: 20,
                                )),
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
                      _authController.user_sign_up(
                          emailController.text,
                          paswordController.text,
                          phoneController.text,
                          usernameController.text);
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
                      "SIGN UP",
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
                                builder: (context) => const Login_page()));
                      },
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: "Already Have an acccount?",
                            style: TextStyle(fontSize: 16)),
                        TextSpan(
                            text: "SIGN IN",
                            style: TextStyle(
                                color: Appcolors.primaryColor,
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
      ),
    );
  }
}
