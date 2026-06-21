import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/SupplierModel.dart';
import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/EventPreparation/PreparationComponents.dart';

class Elements extends StatefulWidget {
  const Elements({super.key});

  @override
  State<Elements> createState() => _ElementsState();
}

class _ElementsState extends State<Elements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppBarEventDetails(context,"مناسباتي",),
          ElementCard(
            service: 'تنظيف منازل',
            supplier: Supplier(
              id: '1',
              arName: 'شركة اللمعة',
              enName: 'Al Lamaa',
              mobile: '0999999999',
              address: 'دمشق',
              email: 'info@lamma.com',
              website: 'www.lamma.com',
              facebookAcc: '',
              xAcc: '',
              instagramAcc: '',
              whatsappAcc: '0999999999',
              telegramAcc: '',
              picture: 'https://via.placeholder.com/150',
              logo: 'https://via.placeholder.com/150',
              statue: 'waiting_confirm', // 🔥 تم الحجز
            ), image: 'https://via.placeholder.com/150',
          ),
          ElementCard(
            service: 'تنظيف منازل',
            supplier: Supplier(
              id: '1',
              arName: 'شركة اللمعة',
              enName: 'Al Lamaa',
              mobile: '0999999999',
              address: 'دمشق',
              email: 'info@lamma.com',
              website: 'www.lamma.com',
              facebookAcc: '',
              xAcc: '',
              instagramAcc: '',
              whatsappAcc: '0999999999',
              telegramAcc: '',
              picture: 'https://via.placeholder.com/150',
              logo: 'https://via.placeholder.com/150',
              statue: 'waiting_confirm', // 🔥 تم الحجز
            ), image: 'https://via.placeholder.com/150',
          ),
          ElementCard(
            service: 'تنظيف منازل',
            supplier: Supplier(
              id: '1',
              arName: 'شركة اللمعة',
              enName: 'Al Lamaa',
              mobile: '0999999999',
              address: 'دمشق',
              email: 'info@lamma.com',
              website: 'www.lamma.com',
              facebookAcc: '',
              xAcc: '',
              instagramAcc: '',
              whatsappAcc: '0999999999',
              telegramAcc: '',
              picture: 'https://via.placeholder.com/150',
              logo: 'https://via.placeholder.com/150',
              statue: 'waiting_confirm', // 🔥 تم الحجز
            ), image: 'https://via.placeholder.com/150',
          ),
          ElementCard(
            service: 'تنظيف منازل',
            supplier: Supplier(
              id: '1',
              arName: 'شركة اللمعة',
              enName: 'Al Lamaa',
              mobile: '0999999999',
              address: 'دمشق',
              email: 'info@lamma.com',
              website: 'www.lamma.com',
              facebookAcc: '',
              xAcc: '',
              instagramAcc: '',
              whatsappAcc: '0999999999',
              telegramAcc: '',
              picture: 'https://via.placeholder.com/150',
              logo: 'https://via.placeholder.com/150',
              statue: 'waiting_confirm', // 🔥 تم الحجز
            ), image: 'https://via.placeholder.com/150',
          ),
          ElementCard(
            service: 'تنظيف منازل',
            supplier: Supplier(
              id: '1',
              arName: 'شركة اللمعة',
              enName: 'Al Lamaa',
              mobile: '0999999999',
              address: 'دمشق',
              email: 'info@lamma.com',
              website: 'www.lamma.com',
              facebookAcc: '',
              xAcc: '',
              instagramAcc: '',
              whatsappAcc: '0999999999',
              telegramAcc: '',
              picture: 'https://via.placeholder.com/150',
              logo: 'https://via.placeholder.com/150',
              statue: 'waiting_confirm', // 🔥 تم الحجز
            ), image: 'https://via.placeholder.com/150',
          )




        ],
      ),
    );
  }
}
