import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Models/UserModel.dart';
import 'EventDetailsComponents.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({super.key});

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  List<UserModel> allUsers = [
    UserModel(
      idUser: 1,
      firstname: 'Ahmad',
      lastname: 'Ali',
      gender: 'Male',
      mobilePhone: '123456789',
      email: 'ahmad@mail.com',
      picture: '',
      username: 'ahmad123',
      password: '12345',
      birthdate: DateTime(1990, 1, 1),
      registerDatetime: DateTime.now(),
      additionUserId: 0,
    ),
    UserModel(
      idUser: 2,
      firstname: 'Sara',
      lastname: 'Khalid',
      gender: 'Female',
      mobilePhone: '987654321',
      email: 'sara@mail.com',
      picture: '',
      username: 'sara456',
      password: '12345',
      birthdate: DateTime(1992, 3, 15),
      registerDatetime: DateTime.now(),
      additionUserId: 0,
    ),
    // أضف باقي المستخدمين هنا...
  ];

  List<UserModel> displayedUsers = [];

  @override
  void initState() {
    super.initState();
    displayedUsers = allUsers; // عرض كل المستخدمين أولًا
  }

  void searchUsers(String query) {
    final filtered = allUsers.where((user) {
      return user.username.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      displayedUsers = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // استخدام SearchBarByUser الموجود
        SearchBarByUser(
          context: context,
          onChanged: searchUsers,
        ),
        const SizedBox(height: 10),

        // عرض النتائج مباشرة أسفل الـ SearchBar
        Expanded(
          child: displayedUsers.isEmpty
              ? Center(
            child: Text(
              'لا يوجد نتائج',
              style: TextStyle(fontSize: w * 0.045),
            ),
          )
              : ListView.builder(
            itemCount: displayedUsers.length,
            itemBuilder: (context, index) {
              final user = displayedUsers[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(user.firstname[0]),
                ),
                title: Text(user.username),
                subtitle: Text('${user.firstname} ${user.lastname}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
