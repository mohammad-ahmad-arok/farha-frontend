import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/profileController.dart';
import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class FinalReset extends StatefulWidget {
  const FinalReset({super.key});

  @override
  State<FinalReset> createState() => _FinalResetState();
}

class _FinalResetState extends State<FinalReset> {
  final ProfileController profileController = Get.put(ProfileController());

  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isLandscape = size.width > size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // تحديث نص الأب بار كما طلبتِ
            AppBarEventDetails(context, "تعيين كلمة مرور جديدة", showLeftButton: false),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.04),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: purple.withOpacity(0.06),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/Resetpassword.png', // استبدلي المسار بمسار الصورة الصحيح لديكِ
                            width: isLandscape ? size.height * 0.20 : size.width * 0.30,
                            height: isLandscape ? size.height * 0.20 : size.width * 0.30,
                            fit: BoxFit.contain,
                            // color: purple, // فكي التعليق عن هذا السطر إذا كنتِ تريدين تلوين الصورة بلون واحد
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),

                      Text(
                        "تغيير كلمة المرور",
                        style: TextStyle(
                          fontSize: isLandscape ? 20 : 22,
                          fontWeight: FontWeight.bold,
                          color: dark,
                          fontFamily: 'BahijTheSansArabic',
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "أدخل بياناتك لتأمين حسابك بكلمة مرور جديدة",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: lightDark,
                          fontFamily: 'BahijTheSansArabic',
                        ),
                      ),

                      SizedBox(height: size.height * 0.05),

                      /// 🔹 منطقة الحقول مع اتجاه Labels من اليمين
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: isLandscape ? 600 : 500),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end, // محاذاة كل العناصر لليمين
                          children: [
                            _buildLabel('كلمة المرور الحالية'),
                            _buildField(
                              hint: 'أدخل كلمة المرور الحالية',
                              controller: _currentPasswordController,
                              obscure: _obscureCurrentPassword,
                              onToggle: () => setState(() => _obscureCurrentPassword = !_obscureCurrentPassword),
                            ),

                            SizedBox(height: size.height * 0.025),

                            _buildLabel('كلمة المرور الجديدة'),
                            _buildField(
                              hint: 'أدخل كلمة المرور الجديدة',
                              controller: _newPasswordController,
                              obscure: _obscureNewPassword,
                              onToggle: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
                            ),

                            const Padding(
                              padding: EdgeInsets.only(top: 8, right: 4),
                              child: Text(
                                '• استخدم 6 خانات على الأقل',
                                style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'BahijTheSansArabic'),
                                textDirection: TextDirection.rtl,
                              ),
                            ),

                            SizedBox(height: size.height * 0.025),

                            _buildLabel('تأكيد كلمة المرور'),
                            _buildField(
                              hint: 'أعد كتابة كلمة المرور الجديدة',
                              controller: _confirmPasswordController,
                              obscure: _obscureConfirmPassword,
                              onToggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.1),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomBarEventDetails(
        context,
        title: _isLoading ? "جاري التحديث..." : "تعديل",
        onPressed: _isLoading ? () {} : _handleUpdate,
      ),
    );
  }

  /// Label يتبع الـ RTL بشكل صريح
  Widget _buildLabel(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 6, right: 4),
      child: Text(
        text,
        textAlign: TextAlign.right, // ضمان المحاذاة لليمين
        textDirection: TextDirection.rtl, // تحديد اتجاه النص
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: dark,
          fontFamily: 'BahijTheSansArabic',
        ),
      ),
    );
  }

  Widget _buildField({
    required String hint,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: const TextStyle(fontSize: 16, color: dark),
        decoration: InputDecoration(
          hintText: hint,
          hintTextDirection: TextDirection.rtl,
          hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(
                obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: lightDark,
                size: 20
            ),
            onPressed: onToggle,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        ),
      ),
    );
  }

  Future<void> _handleUpdate() async {
    if (_currentPasswordController.text.isEmpty || _newPasswordController.text.isEmpty) {
      Get.snackbar("تنبيه", "الرجاء تعبئة كافة البيانات", backgroundColor: Colors.amber, colorText: Colors.white);
      return;
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      Get.snackbar("خطأ", "كلمتا المرور غير متطابقتين", backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    setState(() => _isLoading = true);
    try {
      final success = await profileController.changePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
      );
      if (success) {
        Get.snackbar("تم", "تم تحديث كلمة المرور بنجاح", backgroundColor: Colors.green, colorText: Colors.white);
        Get.back();
      } else {
        Get.snackbar("فشل", "تأكد من كلمة المرور الحالية", backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ غير متوقع", backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}