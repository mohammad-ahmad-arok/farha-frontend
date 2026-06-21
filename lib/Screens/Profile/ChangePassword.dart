import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/profileController.dart';
import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final ProfileController profileController = Get.find<ProfileController>();

  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  // دالة المساعدة للنصوص المكبرة قليلاً كما في صفحة البروفايل
  Widget LabelTextRTL(String label) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16, // حجم مكبر قليلاً للوضوح
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: 'BahijTheSansArabic',
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Widget PasswordFieldRTL({
    required String hint,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleObscure,
    required Size size,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: const TextStyle(
        fontSize: 17,
        color: dark,
        fontFamily: 'BahijTheSansArabic',
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintTextDirection: TextDirection.rtl,
        hintStyle: const TextStyle(fontFamily: 'BahijTheSansArabic', color: lightDark, fontSize: 14),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: dark,
            size: 24,
          ),
          onPressed: onToggleObscure,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * 0.018
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      // منع الزر من القفز فوق الكيبورد وتغطية الحقول
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            AppBarEventDetails(context, "تغيير كلمة المرور", showLeftButton: false),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Center(
                    child: ConstrainedBox(
                      // تحديد عرض أقصى للمحتوى في وضعية اللاندسكيب ليبقى منسقاً
                      constraints: BoxConstraints(maxWidth: isLandscape ? 850 : 550),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: size.height * 0.04),

                          LabelTextRTL('كلمة المرور الحالية'),
                          SizedBox(height: size.height * 0.008),
                          PasswordFieldRTL(
                            hint: 'أدخل كلمة المرور الحالية',
                            controller: _currentPasswordController,
                            obscureText: _obscureCurrentPassword,
                            onToggleObscure: () => setState(() => _obscureCurrentPassword = !_obscureCurrentPassword),
                            size: size,
                          ),
                          SizedBox(height: size.height * 0.035),

                          LabelTextRTL('كلمة المرور الجديدة'),
                          SizedBox(height: size.height * 0.008),
                          PasswordFieldRTL(
                            hint: 'أدخل كلمة المرور الجديدة',
                            controller: _newPasswordController,
                            obscureText: _obscureNewPassword,
                            onToggleObscure: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
                            size: size,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, right: 4),
                            child: const Text(
                              'يجب أن تكون كلمة المرور 6 أحرف على الأقل',
                              style: TextStyle(fontSize: 13, color: lightDark, fontFamily: 'BahijTheSansArabic'),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                          SizedBox(height: size.height * 0.035),

                          LabelTextRTL('تأكيد كلمة المرور الجديدة'),
                          SizedBox(height: size.height * 0.008),
                          PasswordFieldRTL(
                            hint: 'أعد إدخال كلمة المرور الجديدة',
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            onToggleObscure: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                            size: size,
                          ),

                          // مساحة مرنة في الأسفل لضمان تجربة سكرول مريحة
                          SizedBox(height: size.height * 0.1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // تثبيت الزر في الأسفل تماماً كما في صفحة التعديل
      bottomNavigationBar: bottomBarEventDetails(
        context,
        title: _isLoading ? "جاري التغيير..." : "تعديل",
        onPressed: _isLoading ? () {} : _changePassword,
      ),
    );
  }

  // --- المنطق (Logic) الخاص بالحفظ والتحقق ---

  bool _validatePasswords() {
    if (_currentPasswordController.text.isEmpty) {
      _showSnackBar('الرجاء إدخال كلمة المرور الحالية', Colors.red);
      return false;
    }
    if (_newPasswordController.text.length < 6) {
      _showSnackBar('كلمة المرور الجديدة يجب أن تكون 6 أحرف على الأقل', Colors.red);
      return false;
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showSnackBar('كلمة المرور الجديدة وتأكيدها غير متطابقين', Colors.red);
      return false;
    }
    return true;
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  Future<void> _changePassword() async {
    if (!_validatePasswords()) return;
    setState(() => _isLoading = true);
    try {
      final success = await profileController.changePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
      );
      if (success) {
        _showSnackBar('تم تغيير كلمة المرور بنجاح', Colors.green);
        Get.back();
      } else {
        _showSnackBar('فشل التغيير. تحقق من كلمة المرور الحالية', Colors.red);
      }
    } catch (e) {
      _showSnackBar('حدث خطأ غير متوقع', Colors.red);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}