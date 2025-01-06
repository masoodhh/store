import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/params/text_styles.dart';

import '../../../../core/params/colors.dart';
import '../../../../core/widgets/spacer.widget.dart';
import '../../../cart/presentation/manager/checkout/checkout_bloc.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  static const routeName = '/order_details';

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    BlocProvider.of<CheckoutBloc>(context).add(initializeEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: dispose controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomSheet: _buildTotalPrice(),
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 110,
    backgroundColor: MyColors.primaryColor,
    title: const Text(
      "Order details",
      style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    leadingWidth: 70,
    leading: Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.white)),
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
      ),
    ),
  );
}

Widget _buildBody(BuildContext context) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: MyColors.primaryColor,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: MyColors.primaryBackgroundColor,
      ),
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildDetails(),
            SizedBox(
              height: 20,
            ),
            _buildProducts(),
          ],
        ),
      ),
    ),
  );
}

Widget _buildDetails() {
  return Container(
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.white),
    child: Column(
      children: [
        _buildDetailsItem("9:30 AM", true, "Order Placed", "your order has been placed successfully"),
        _buildDetailsItem(
            "9:35 AM", true, "Pending", "your order is being prepared to be processed and processed"),
        _buildDetailsItem(
            "9:35 AM", true, "Confirmed", "your order is being prepared to be processed and processed"),
        _buildDetailsItem("", false, "Processing",
            "your order is being prepared to be processed and order is being prepared to be processed and processed order  is being prepared to be processed and processed"),
        _buildDetailsItem(
            "", false, "Confirmed", "your order is being prepared to be processed and processed"),
      ],
    ),
  );
}

Widget _buildDetailsItem(String time, bool isPassed, String title, String description) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            time,
            style: MyTextStyles.header3,
          ),
        ),
      ),
      SizedBox(
        width: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.primaryColor,
                  border: Border.all(width: 2, color: MyColors.primaryColor)),
              child: isPassed
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 25,
                    )
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      )),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: 1,
              height: 80,
              color: MyColors.primaryColor,
            )
          ],
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 4, left: 20),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MyTextStyles.header2,
                ),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: MyTextStyles.headline,
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}

Widget _buildProducts() {
  return Container(
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.white),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Products",
          style: MyTextStyles.header,
        )
      ],
    ),
  );
}

Widget _buildTotalPrice() {
  return Container(
    padding: const EdgeInsets.all(10),
    child: Container(
      height: 60,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: MyColors.primaryColor,
      ),
      child: const Center(
        child: Text(
          "Location Map",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

void addCard(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    // isDismissible: false, // غیرفعال کردن بسته شدن دیالوگ با کلیک خارج از آن
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)), // گوشه‌های گرد در بالای دیالوگ
    ),
    builder: (BuildContext context) {
      final TextEditingController _paymenttitleController = TextEditingController();
      final TextEditingController _paymentCvvController = TextEditingController();
      final TextEditingController _paymentCardNumberController = TextEditingController();
      final TextEditingController _paymentDateController = TextEditingController();
      return Container(
        height: 450, // ارتفاع دیالوگ
        padding: const EdgeInsets.all(16), // فاصله داخلی
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add a Card",
                  style: TextStyle(color: MyColors.primaryColor, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle, // شکل دایره
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // بستن دیالوگ
                    },
                  ),
                ),
              ],
            ),
            SpacerV(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200], // رنگ پس‌زمینه
                borderRadius: BorderRadius.circular(30), // گرد کردن گوشه‌ها
              ),
              child: Row(
                children: [
                  const Text(
                    'title'
                    ' :',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 10), // فاصله بین لیبل و فیلد
                  Expanded(
                    child: TextField(
                      controller: _paymenttitleController,
                      keyboardType: TextInputType.number, // فقط ورودی عدد
                      decoration: const InputDecoration(
                        border: InputBorder.none, // حذف حاشیه TextField
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SpacerV(20),
            TextField(
              controller: _paymentCardNumberController,
              keyboardType: TextInputType.number, // فقط ورودی عدد
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                hintText: "**** **** **** ****",
                hintStyle: const TextStyle(color: Colors.black45),
                prefixIcon: const Icon(Icons.payment),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // فقط عدد قبول می‌کند
                LengthLimitingTextInputFormatter(16), // حداکثر 19 کاراکتر (شامل فاصله‌ها)
                CardNumberInputFormatter(),
              ],
            ),
            SpacerV(20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // رنگ پس‌زمینه
                      borderRadius: BorderRadius.circular(30), // گرد کردن گوشه‌ها
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'MM/YY'
                          ' :',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 10), // فاصله بین لیبل و فیلد
                        Expanded(
                          child: TextField(
                              keyboardType: TextInputType.number, // فقط ورودی عدد
                              controller: _paymentDateController,
                              decoration: const InputDecoration(
                                border: InputBorder.none, // حذف حاشیه TextField
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly, // فقط عدد قبول می‌کند
                                LengthLimitingTextInputFormatter(4), // حداکثر 19 کاراکتر (شامل فاصله‌ها)
                                CardDateInputFormatter(),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // رنگ پس‌زمینه
                      borderRadius: BorderRadius.circular(30), // گرد کردن گوشه‌ها
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'CVV :',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 10), // فاصله بین لیبل و فیلد
                        Expanded(
                          child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _paymentCvvController,
                              decoration: const InputDecoration(
                                border: InputBorder.none, // حذف حاشیه TextField
                              ),
                              onSubmitted: (value) {
                                BlocProvider.of<CheckoutBloc>(context).add(addPaymentCardEvent(
                                    title: _paymenttitleController.text,
                                    card_number: _paymentCardNumberController.text,
                                    date: _paymentDateController.text,
                                    CVV: int.parse(_paymentCvvController.text),
                                    icon: Icons.payment));
                                Navigator.pop(context);
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly, // فقط عدد قبول می‌کند
                                LengthLimitingTextInputFormatter(4), // حداکثر 19 کاراکتر (شامل فاصله‌ها)
                              ]),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                BlocProvider.of<CheckoutBloc>(context).add(addPaymentCardEvent(
                    title: _paymenttitleController.text,
                    card_number: _paymentCardNumberController.text,
                    date: _paymentDateController.text,
                    CVV: int.parse(_paymentCvvController.text),
                    icon: Icons.payment));
                Navigator.pop(context);
              },
              child: Container(
                height: 60,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: MyColors.primaryColor,
                ),
                child: const Center(
                  child: Text(
                    "Add New Card",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void addAddress(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    // isDismissible: false, // غیرفعال کردن بسته شدن دیالوگ با کلیک خارج از آن
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)), // گوشه‌های گرد در بالای دیالوگ
    ),
    builder: (BuildContext context) {
      final TextEditingController _addressTitleController = TextEditingController();
      final TextEditingController _addressAddressController = TextEditingController();
      return Container(
        height: 450, // ارتفاع دیالوگ
        padding: const EdgeInsets.all(16), // فاصله داخلی
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add an Address",
                  style: TextStyle(color: MyColors.primaryColor, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle, // شکل دایره
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // بستن دیالوگ
                    },
                  ),
                ),
              ],
            ),
            SpacerV(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200], // رنگ پس‌زمینه
                borderRadius: BorderRadius.circular(30), // گرد کردن گوشه‌ها
              ),
              child: Row(
                children: [
                  const Text(
                    'title'
                    ' :',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 10), // فاصله بین لیبل و فیلد
                  Expanded(
                    child: TextField(
                      controller: _addressTitleController,
                      keyboardType: TextInputType.number, // فقط ورودی عدد
                      decoration: const InputDecoration(
                        border: InputBorder.none, // حذف حاشیه TextField
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SpacerV(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200], // رنگ پس‌زمینه
                borderRadius: BorderRadius.circular(30), // گرد کردن گوشه‌ها
              ),
              child: Row(
                children: [
                  const Text(
                    'Address :',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 10), // فاصله بین لیبل و فیلد
                  Expanded(
                    child: TextField(
                      controller: _addressAddressController,
                      keyboardType: TextInputType.number, // فقط ورودی عدد
                      decoration: const InputDecoration(
                        border: InputBorder.none, // حذف حاشیه TextField
                      ),
                      onSubmitted: (value) {
                        BlocProvider.of<CheckoutBloc>(context).add(addAddressEvent(
                            title: _addressTitleController.text,
                            address: _addressAddressController.text,
                            icon: Icons.home));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                BlocProvider.of<CheckoutBloc>(context).add(addAddressEvent(
                    title: _addressTitleController.text,
                    address: _addressAddressController.text,
                    icon: Icons.home));
                Navigator.pop(context);
              },
              child: Container(
                height: 60,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: MyColors.primaryColor,
                ),
                child: const Center(
                  child: Text(
                    "Add New Address",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // حذف فاصله‌های قبلی
    String newText = newValue.text.replaceAll(' ', '');

    // ساختن رشته جدید با فاصله هر ۴ رقم
    String formatted = '';
    for (int i = 0; i < newText.length; i++) {
      if (i % 4 == 0 && i != 0) {
        formatted += ' ';
      }
      formatted += newText[i];
    }

    // بازگشت به موقعیت فعلی نشانگر متن
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class CardDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll('/', '');

    String formatted = '';

    // اگر طول رشته جدید بیشتر از 0 است، رقم اول باید فقط "0" یا "1" باشد
    if (newText.isNotEmpty) {
      if (newText[0] != '0' && newText[0] != '1') {
        // حذف هر رقمی غیر از "0" و "1" در رقم اول
        newText = '';
      }
    }

    // اگر دو رقم وارد شده است، بررسی کنید که ماه معتبر باشد (نباید بیشتر از 12 باشد)
    if (newText.length > 1) {
      String monthString = newText.substring(0, 2);
      int? month = int.tryParse(monthString);

      if (month != null && month > 12) {
        // اگر ماه بیشتر از 12 باشد، رقم دوم حذف می‌شود
        newText = newText.substring(0, 1); // نگه داشتن رقم اول و حذف رقم دوم
      }
    }

    // افزودن اسلش (/) پس از هر دو رقم
    for (int i = 0; i < newText.length; i++) {
      if (i % 2 == 0 && i != 0) {
        formatted += '/';
      }
      formatted += newText[i];
    }

    // بازگشت به موقعیت فعلی نشانگر متن
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
