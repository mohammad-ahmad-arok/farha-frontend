import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Api/authApi.dart';
import '../Models/registerUserModel.dart';
import '../Screens/auth/LogIn.dart';
import '../Screens/auth/OtpScreen.dart';
import '../Screens/home-layout/Home-layout.dart';
import '../Shared/Components/components.dart';
import '../Shared/sharedPreferences.dart';

class RegisterController extends GetxController {
  var isRememberMe = false.obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  var selectedCountryCode = '+963'.obs;
  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;
  var selectedGender = 'ذكر'.obs;
  final birthdayController = TextEditingController();
  var isAccepted = false.obs;
  final storage = StorageService();
  var isLoading = false.obs;
  var serverOtpCode = ''.obs;
  bool validateFirstStep() {
    if (firstNameController.text.isEmpty || lastNameController.text.isEmpty) {
      Get.snackbar("خطأ", "يرجى إدخال الاسم كاملاً");
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar("خطأ", "البريد الإلكتروني غير صالح");
      return false;
    }
    if (phoneController.text.length < 9) {
      Get.snackbar("خطأ", "رقم الهاتف غير مكتمل");
      return false;
    }
    if (passController.text.length < 8) {
      Get.snackbar("خطأ", "كلمة المرور يجب أن تكون 8 محارف على الأقل");
      return false;
    }
    if (passController.text != confirmPassController.text) {
      Get.snackbar("خطأ", "كلمات المرور غير متطابقة");
      return false;
    }
    return true;
  }


  Future<bool> signup() async {
    if (!isAccepted.value) {
      showCustomSnackBar("تنبيه", "يجب الموافقة على الشروط والأحكام");
      return false;
    }

    try {
      isLoading.value = true;

      String rawDate = birthdayController.text;
      List<String> parts = rawDate.split('/');
      if (parts.length < 3) {
        showCustomSnackBar("تنبيه", "تنسيق التاريخ غير صحيح (يجب أن يكون يوم/شهر/سنة)");
        return false;
      }
      String formattedDate = "${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}";

      RegisterUserModel user = RegisterUserModel(
          first_name: firstNameController.text,
          last_name: lastNameController.text,
          mobile_phone: "${selectedCountryCode.value}${phoneController.text}",
          password: passController.text,
          gender: selectedGender.value == 'ذكر' ? 'male' : 'female',
          birthdate: formattedDate,
          email: emailController.text,
          username: userNameController.text);

      final response = await authApi.registerUser(user);

      if (response != null && response.success) {
        serverOtpCode.value = response.data?.code ?? '';
        return true;
      } else {
        showCustomSnackBar("تنبيه", response?.message ?? "فشل التسجيل، حاول مرة أخرى");
        return false;
      }
    } catch (e) {
      showCustomSnackBar("خطأ", "حدث خطأ في الاتصال بالسيرفر");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  Future<bool> loginUser() async {
    if (emailController.text.isEmpty || passController.text.isEmpty) {
      Get.snackbar("تنبيه", "يرجى ملء جميع الحقول");
      return false;
    }

    try {
      isLoading.value = true;
      var response = await authApi.login(emailController.text, passController.text);

      if (response != null && response.success) {
        if (response.data?.token != null) {
          await StorageService.saveToken(response.data!.token!);
        }

        if (isRememberMe.value) {
          await StorageService.setLoggedIn(true);
        } else {
          await StorageService.setLoggedIn(false);
        }

        Get.snackbar("نجاح", "أهلاً بك ${response.data?.user?.firstName}");
        return true;
      } else {
        Get.snackbar("خطأ", response?.message ?? "فشل تسجيل الدخول");
        return false;
      }
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> sendOtpCode(String identifier) async {
    try {
      isLoading.value = true;
      final otpResponse = await authApi().sendOtp(identifier);

      if (otpResponse.success && otpResponse.data != null) {
        serverOtpCode.value = otpResponse.data!.code ?? '';
        print("✅ الرمز المستلم: ${serverOtpCode.value}");
      } else {
        print("❌ فشل في استلام الرمز: ${otpResponse.message}");
      }
    } catch (e) {
      print("❌ خطأ في الاتصال: $e");
    } finally {
      isLoading.value = false;
    }
  }
  void verifyCodeLocally(String enteredCode) {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      if (enteredCode == serverOtpCode?.value) {
        isLoading.value = false;
        Get.snackbar('نجاح', 'تم التحقق بنجاح');
         Get.offAll(HomeLayout());
      } else {
        isLoading.value = false;
        Get.snackbar('خطأ', 'الرمز غير صحيح');
      }
    });
  }
  String maskEmail(String email) {
    if (email.isEmpty || !email.contains('@')) return email;

    final parts = email.split('@');
    String username = parts[0];
    String domain = parts[1];

    if (username.length <= 4) {
      return "${username[0]}****@$domain";
    }

    String firstTwo = username.substring(0, 2);
    String lastTwo = username.substring(username.length - 2);
    String stars = '*' * (username.length - 4);

    return "$firstTwo$stars$lastTwo@$domain";
  }

}