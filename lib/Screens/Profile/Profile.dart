import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../Controllers/profileController.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Style/Colors.dart';
import 'ContactUs.dart';
import 'EditProfile.dart';
import 'FaqPage.dart';
import 'Language.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool notificationsEnabled = true;
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double h = size.height;
    final double w = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBarEventDetails(context, "الملف الشخصي", showLeftButton: false),
          Expanded(
            child: Obx(() {
              if (profileController.isLoading.value) {
                return const Center(child: CircularProgressIndicator(color: purple));
              }
              if (profileController.profile.value == null) {
                return _buildErrorState();
              }
              final profile = profileController.profile.value!;

              return OrientationBuilder(
                builder: (context, orientation) {
                  bool isLandscape = orientation == Orientation.landscape;

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04,
                      vertical: h * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileHeader(profile, w, h),

                        SizedBox(height: h * 0.03),

                        if (isLandscape)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _sectionTitle('الإعدادات العامة', h),
                                    _buildPersonalCard(w, h),
                                    SizedBox(height: h * 0.03),
                                    _sectionTitle('معلومات الحساب', h),
                                    _buildAccountCard(w, h),
                                  ],
                                ),
                              ),
                              SizedBox(width: w * 0.04),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _sectionTitle('مركز المساعدة والدعم', h),
                                    _buildHelpCard(w, h),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _sectionTitle('الإعدادات العامة', h),
                              _buildPersonalCard(w, h),
                              SizedBox(height: h * 0.03),
                              _sectionTitle('معلومات الحساب', h),
                              _buildAccountCard(w, h),
                              SizedBox(height: h * 0.03),
                              _sectionTitle('مركز المساعدة والدعم', h),
                              _buildHelpCard(w, h),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, double h) {
    return Padding(
      padding: EdgeInsets.only(bottom: h * 0.015),
      child: IntroSecondText(subtitle: title, color: secondText, size: 14),
    );
  }

  Widget _buildProfileHeader(dynamic profile, double w, double h) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFBFD),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: EdgeInsets.all(w * 0.032),
        child: Row(
          children: [
            CircleAvatar(
              radius: w * 0.08 > 30 ? 30 : w * 0.08,
              backgroundColor: purple.withOpacity(0.1),
              backgroundImage: profile.picture != null ? NetworkImage(profile.picture!) : null,
              child: profile.picture == null ? Icon(Icons.person, color: purple, size: w * 0.07) : null,
            ),
            SizedBox(width: w * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntroSecondText(subtitle: '${profile.firstName ?? ''} ${profile.lastName ?? ''}', color: dark, size: 14),
                  SizedBox(height: h * 0.005),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 18, color: Colors.grey[600]),
                      SizedBox(width: w * 0.01),
                      IntroSecondText(subtitle: 'فلسطين', color: secondText, size: 12),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // تم تعديل الـ InkWell ليشمل الكارد بالكامل
  Widget _buildPersonalCard(double w, double h) {
    return _cardContainer(
      child: InkWell(
        onTap: () => Get.to(() => const Editprofile()),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.032, vertical: h * 0.02),
          child: Row(
            children: [
              _iconBox("assets/purpleprofileIcon.webp"),
              SizedBox(width: w * 0.03),
              const Expanded(
                  child: Text(
                      'البيانات الشخصية',
                      style: TextStyle(fontSize: 14, color: dark, fontFamily: 'BahijTheSansArabic')
                  )
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountCard(double w, double h) {
    return _cardContainer(
      child: Column(
        children: [
          _rowItem(w, h, "assets/notify.webp", 'الإشعارات', isSwitch: true),
          Divider(height: 1, color: Colors.grey[300], indent: w * 0.12),
          _rowItem(w, h, "assets/language.webp", 'اللغة', trailing: 'العربية', onTap: () => showLanguagePopup(context)),
        ],
      ),
    );
  }

  Widget _buildHelpCard(double w, double h) {
    return _cardContainer(
      child: Column(
        children: [
          _rowItem(w, h, "assets/questions.webp", 'الأسئلة الشائعة', onTap: () => Get.to(() => const FaqPage())),
          Divider(height: 1, color: Colors.grey[300], indent: w * 0.12),
          _rowItem(w, h, "assets/contactUs.webp", 'تواصل معنا', onTap: () => Get.to(() => const ContactUsPage())),
          Divider(height: 1, color: Colors.grey[300], indent: w * 0.12),
          _rowItem(w, h, "assets/about.webp", 'عن التطبيق', onTap: () {}),
          Divider(height: 1, color: Colors.grey[300], indent: w * 0.12),
          _rowItem(w, h, "assets/privecy.webp", 'سياسة الخصوصية', onTap: () {}),
        ],
      ),
    );
  }

  Widget _cardContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFBFD),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: child,
    );
  }

  Widget _rowItem(double w, double h, String icon, String title, {bool isSwitch = false, String? trailing, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.032, vertical: h * 0.018),
        child: Row(
          children: [
            _iconBox(icon),
            SizedBox(width: w * 0.03),
            Expanded(
                child: Text(
                    title,
                    style: const TextStyle(fontSize: 14, color: dark, fontFamily: 'BahijTheSansArabic')
                )
            ),
            if (isSwitch)
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                    value: notificationsEnabled,
                    onChanged: (v) => setState(() => notificationsEnabled = v),
                    activeColor: purple
                ),
              )
            else ...[
              if (trailing != null)
                Text(trailing, style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'BahijTheSansArabic')),
              SizedBox(width: w * 0.02),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ]
          ],
        ),
      ),
    );
  }

  Widget _iconBox(String path) {
    return Container(
      width: 24, height: 24,
      decoration: BoxDecoration(color: const Color(0xFFF6ECF4), borderRadius: BorderRadius.circular(4)),
      child: Image.asset(path),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('لا توجد بيانات', style: TextStyle(color: Colors.red)),
          SizedBox(height: Get.height * 0.02),
          ElevatedButton(onPressed: profileController.fetchProfile, child: const Text('إعادة المحاولة')),
        ],
      ),
    );
  }
}