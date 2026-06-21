import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../Api/profileApi.dart';
import '../Models/ProfileResponseModel.dart';
import '../Models/ResetPasswordRequest.dart';

class ProfileController extends GetxController {
  var profile = Rx<ProfileData?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final response = await ProfileApi.getProfile();
      // تأكد من استخدام success بشكل صحيح
      if (response != null && response.success) {
        profile.value = response.data;
      } else {
        Get.snackbar('خطأ', response?.message ?? 'فشل تحميل الملف الشخصي');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ في الاتصال');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    required String email, // تأكد من وجوده هنا
    required String username,
    required String mobilePhone,
    String? birthdate,
    String? gender,
  }) async {
    try {
      isLoading.value = true;

      String formattedDate = birthdate ?? "";
      if (formattedDate.contains('/')) {
        List<String> parts = formattedDate.split('/');
        if (parts.length == 3) {
          formattedDate = "${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}";
        }
      }
      final response = await ProfileApi.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email, // 👈 تأكد من تمريره هنا
        username: username,
        mobilePhone: mobilePhone,
        birthdate: formattedDate,
        gender: gender,
      );

      if (response != null && response.success) {
        profile.value = response.data;
        profile.refresh();
        Get.snackbar('نجاح', 'تم تحديث البيانات'); // لن تظهر إلا إذا كان response.success true
        return true;
      } else {
        // 💡 أضف رسالة هنا لتعرف لماذا فشل
        Get.snackbar('تنبيه', response?.message ?? 'فشل التحديث من السيرفر');
        return false;
      }
    } finally {
      isLoading.value = false;
    }
  }


  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      isLoading.value = true;
      final response = await ProfileApi.uploadProfileImage(imageFile);
      if (response != null && response.success) {
        // تحديث الصورة باستخدام copyWith (يجب إضافتها في ProfileData)
        if (response.data != null) {
          profile.value = profile.value?.copyWith(picture: response.data!.picture);
        }
        Get.snackbar('نجاح', 'تم تحديث الصورة الشخصية');
        return response.data?.picture;
      } else {
        Get.snackbar('فشل', response?.message ?? 'حدث خطأ في رفع الصورة');
        return null;
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      isLoading.value = true;
      final response = await ProfileApi.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      if (response != null && response.success == true) {
        Get.snackbar('نجاح', response.message);
        return true;
      } else {
        Get.snackbar('فشل', response?.message ?? 'حدث خطأ');
        return false;
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
// أضيفي هذه الدالة داخل ProfileController
  void updateProfileDataManual(ProfileData newData) {
    profile.value = newData;
    profile.refresh(); // لضمان أن Obx في الواجهة ستتحسس التغيير فوراً
  }
  void refreshProfile() => fetchProfile();
}