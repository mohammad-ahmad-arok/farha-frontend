import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../Controllers/authController.dart';
import '../../Controllers/profileController.dart';
import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';
import 'ChangePassword.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final ProfileController profileController = Get.find<ProfileController>();
  final RegisterController regController = Get.put(RegisterController());

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentData();
  }

  void _loadCurrentData() {
    final profile = profileController.profile.value;
    if (profile != null) {
      regController.firstNameController.text = profile.firstName ?? '';
      regController.lastNameController.text = profile.lastName ?? '';
      regController.userNameController.text = profile.username ?? '';
      regController.emailController.text = profile.email ?? '';
      regController.phoneController.text = profile.mobilePhone ?? '';
      regController.birthdayController.text = profile.birthdate ?? '';
      regController.selectedGender.value = (profile.gender == 'male' || profile.gender == 'ذكر') ? 'ذكر' : 'أنثى';
    }
  }

  // ==================== دوال المنطق (Logic) ====================

  Future<void> _pickImage() async {
    showModalBottomSheet(
      backgroundColor: light,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library, color: purple, size: 24),
                  title: IntroSecondText(subtitle: 'اختر من المعرض', color: dark, size: 15),
                  onTap: () async {
                    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) setState(() => _profileImage = File(image.path));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera, color: purple, size: 24),
                  title: IntroSecondText(subtitle: 'التقط صورة', color: dark, size: 15),
                  onTap: () async {
                    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                    if (image != null) setState(() => _profileImage = File(image.path));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleUpdate() async {
    if (_isUpdating) return;
    setState(() => _isUpdating = true);
    try {
      if (_profileImage != null) await profileController.uploadProfileImage(_profileImage!);

      String phoneText = regController.phoneController.text;
      String countryCode = regController.selectedCountryCode.value;
      String cleanPhone = phoneText.startsWith('+') ? phoneText : "$countryCode$phoneText";

      String birthDate = regController.birthdayController.text;
      if (birthDate.contains('/')) {
        List<String> parts = birthDate.split('/');
        if (parts.length == 3) birthDate = "${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}";
      }

      bool success = await profileController.updateProfile(
        firstName: regController.firstNameController.text,
        lastName: regController.lastNameController.text,
        email: regController.emailController.text,
        username: regController.userNameController.text,
        mobilePhone: cleanPhone,
        birthdate: birthDate,
        gender: regController.selectedGender.value == 'ذكر' ? 'male' : 'female',
      );

      if (success && mounted) Get.back();
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  // ==================== بناء الواجهة (Responsive UI) ====================

  Widget labelTextRTL(String label) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 15, // تكبير درجة واحدة
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: 'BahijTheSansArabic',
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Widget inputFieldRTL({
    required String hint,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required Size size,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: const TextStyle(fontSize: 17, color: dark, fontFamily: 'BahijTheSansArabic'),
      decoration: InputDecoration(
        hintText: hint,
        hintTextDirection: TextDirection.rtl,
        hintStyle: const TextStyle(fontFamily: 'BahijTheSansArabic', color: lightDark, fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.018),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      // لضمان عدم صعود الزر مع الكيبورد، نثبته في الأسفل عبر bottomNavigationBar
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            AppBarEventDetails(context, "الملف الشخصي", showLeftButton: false),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isLandscape ? 850 : 550),
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.03),
                          _buildProfileImage(size),
                          SizedBox(height: size.height * 0.04),

                          _fieldWithLabel("الاسم الأول", "أدخل الأول", regController.firstNameController, size),
                          _fieldWithLabel("الاسم الأخير", "أدخل الأخير", regController.lastNameController, size),
                          _fieldWithLabel("البريد الإلكتروني", "أدخل البريد", regController.emailController, size),
                          _phoneField(size),
                          _fieldWithLabel("اسم المستخدم", "أدخل اسم المستخدم", regController.userNameController, size),
                          _genderField(size),
                          _fieldWithLabel("تاريخ الميلاد", "أدخل التاريخ", regController.birthdayController, size),

                          _changePasswordLink(size),
                          SizedBox(height: size.height * 0.05),
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
      // الزر ثابت في الأسفل ولا يرتفع مع الكيبورد بسبب resizeToAvoidBottomInset: false
      bottomNavigationBar: bottomBarEventDetails(
        context,
        title: _isUpdating ? "جاري التحديث..." : "تعديل",
        onPressed: _isUpdating ? () {} : _handleUpdate,
      ),
    );
  }

  // --- أدوات المساعدة للبناء ---

  Widget _buildProfileImage(Size size) {
    double imgSize = (size.width * 0.35).clamp(110.0, 130.0);
    return Stack(
      children: [
        Obx(() {
          final picture = profileController.profile.value?.picture;
          return Container(
            width: imgSize, height: imgSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE5E2DD), width: 3),
              image: _profileImage != null
                  ? DecorationImage(image: FileImage(_profileImage!), fit: BoxFit.cover)
                  : DecorationImage(image: NetworkImage(picture ?? 'https://via.placeholder.com/150'), fit: BoxFit.cover),
            ),
          );
        }),
        Positioned(
          bottom: 4, right: 4,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: imgSize * 0.28, height: imgSize * 0.28,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: purple),
              child: Icon(Icons.edit, color: Colors.white, size: imgSize * 0.14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _fieldWithLabel(String label, String hint, TextEditingController controller, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        labelTextRTL(label),
        SizedBox(height: size.height * 0.008),
        inputFieldRTL(hint: hint, controller: controller, keyboardType: TextInputType.text, size: size),
        SizedBox(height: size.height * 0.04),
      ],
    );
  }

  Widget _phoneField(Size size) {
    return Column(
      children: [
        labelTextRTL("رقم الهاتف"),
        SizedBox(height: size.height * 0.008),
        Row(
          textDirection: TextDirection.ltr,
          children: [
            Expanded(
              flex: 5,
              child: inputFieldRTL(hint: "رقم الهاتف", controller: regController.phoneController, keyboardType: TextInputType.phone, size: size),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: Obx(() => DropdownButtonFormField<String>(
                isExpanded: true,
                value: regController.selectedCountryCode.value,
                style: const TextStyle(fontSize: 15, color: dark, fontFamily: 'BahijTheSansArabic'),
                items: ['+963', '+966', '+971'].map((c) => DropdownMenuItem(value: c, child: FittedBox(child: Text(c)))).toList(),
                onChanged: (v) => regController.selectedCountryCode.value = v!,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                ),
              )),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.04),
      ],
    );
  }

  Widget _genderField(Size size) {
    return Column(
      children: [
        labelTextRTL("الجنس"),
        SizedBox(height: size.height * 0.008),
        Obx(() => GenderDropdown(
          value: regController.selectedGender.value,
          onChanged: (val) => regController.selectedGender.value = val!,
        )),
        SizedBox(height: size.height * 0.04),
      ],
    );
  }

  Widget _changePasswordLink(Size size) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => Get.to(const ChangePassword()),
        child: const Text(
            "تغيير كلمة المرور",
            style: TextStyle(
                color: purple,
                fontSize: 15,
                decoration: TextDecoration.underline,
                fontFamily: 'BahijTheSansArabic'
            )
        ),
      ),
    );
  }
}