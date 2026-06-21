import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Api/authApi.dart';
import '../Home/Home-layout.dart';
import '../Models/registerUserModel.dart';
import '../shared/components.dart';
import '../sharedPreferences.dart';

class RegisterController extends GetxController {
  ///////////sing up && sign in && OTP
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
      return false; // نرجع false لأن الشرط لم يتحقق
    }

    try {
      isLoading.value = true;

      // تجهيز البيانات
      String rawDate = birthdayController.text;
      List<String> parts = rawDate.split('/');

      // تأكد من أن التاريخ المدخل صحيح قبل التحويل لتجنب الـ Crash
      if (parts.length < 3) {
        showCustomSnackBar("تنبيه", "تنسيق التاريخ غير صحيح");
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
        print("الرمز المستلم من السيرفر هو: ${serverOtpCode.value}");

        // لا ننتقل من هنا إذا كنت تريد التحكم بالانتقال عبر الـ .then() في الـ UI
        // أو يمكنك الانتقال من هنا وإرجاع true
        return true;
      } else {
        showCustomSnackBar("فشل", response?.message ?? "خطأ في التسجيل");
        return false;
      }
    } catch (e) {
      print("Exception during signup: $e");
      showCustomSnackBar("خطأ", "حدث خطأ غير متوقع");
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
        // 3. حل مشكلة دالة write (استبدالها بالدوال التي عرفناها في StorageService)
        if (response.data?.token != null) {
          await StorageService.saveToken(response.data!.token!);
        }

        // إذا أردت حفظ الاسم أيضاً، يمكنك إضافة دالة saveUserName في StorageService
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
        // تعيين القيمة باستخدام .value
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
  }  // دالة التحقق المحلي
  void verifyCodeLocally(String enteredCode) {
    isLoading.value = true;
    // يمكن إضافة تأخير صغير لإظهار الـ loading
    Future.delayed(const Duration(milliseconds: 500), () {
      if (enteredCode == serverOtpCode?.value) {
        // الرمز صحيح
        isLoading.value = false;
        // الانتقال إلى الشاشة التالية أو تنفيذ الإجراء المناسب
        Get.snackbar('نجاح', 'تم التحقق بنجاح');
         Get.offAll(HomeLayout());
      } else {
        isLoading.value = false;
        Get.snackbar('خطأ', 'الرمز غير صحيح');
      }
    });
  }
}