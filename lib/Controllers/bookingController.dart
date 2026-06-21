import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Api/bookingApi.dart';
import '../Models/BookingModel.dart';
import '../Shared/Components/components.dart';

class EventController extends GetxController {
  // بيانات الخدمة (القادمة من صفحة التفاصيل)
  var serviceName = "".obs;
  var price = 0.0.obs;
  var supplierId = 1.obs; // افتراضي

  // بيانات الحجز (يتم اختيارها من التقويم)
  var selectedDate = DateTime.now().obs;
  var selectedTime = "".obs;
  var isLoading = false.obs;

  // دالة لتعبئة بيانات الخدمة عند فتح صفحة التفاصيل
  void setServiceDetails({required String name, required double priceVal}) {
    serviceName.value = name;
    price.value = priceVal;
  }
// دالة لتحديث البيانات من صفحة التفاصيل
  void updateServiceInfo({required double p, required String name, required int id}) {
    price.value = p;
    serviceName.value = name;
    supplierId.value = id;
  }
  // تعريف السيرفس في بداية الكلاس
  final EventService _eventService = EventService();

  Future<void> submitBooking() async {
    try {
      isLoading.value = true;

      // 1. بناء المودل بالبيانات المطلوبة
      EventItemModel finalData = EventItemModel(
        userEventItemsId: 1, // تأكد إذا كان هذا الرقم ثابتاً أو يأتي من مكان آخر
        supplierElementId: supplierId.value,
        price: price.value,
        startDateTime: selectedDate.value,
        note: "حجز لخدمة: ${serviceName.value}",
        count: 1,
        withDelivery: false,
      );

      // 2. استدعاء دالة الـ API التي كتبتها أنت
      bool success = await _eventService.sendEventItem(finalData);

      // 3. التعامل مع النتيجة وإظهار رسائل للمستخدم
      if (success) {
        Get.snackbar(
          "نجاح",
          "تمت عملية الحجز بنجاح",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // يمكنك هنا التنقل لشاشة أخرى أو تصفير الحقول
      } else {
        Get.snackbar(
          "فشل",
          "حدث خطأ أثناء الحجز، يرجى المحاولة لاحقاً",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error in submitBooking: $e");
      showCustomSnackBar("خطأ", "حدث خطأ غير متوقع");
    } finally {
      isLoading.value = false;
    }
  }
}