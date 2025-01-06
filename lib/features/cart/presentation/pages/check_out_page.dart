import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/manager/cart/cart_bloc.dart';

import '../../../../core/params/colors.dart';
import '../../../../core/widgets/spacer.widget.dart';
import '../manager/checkout/checkout_bloc.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  static const routeName = '/checkout';

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
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
      bottomSheet: _buildTotalPrice(context),
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 110,
    backgroundColor: MyColors.primaryColor,
    title: const Text(
      "CheckOut",
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
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        color: MyColors.primaryBackgroundColor,
      ),
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
          child: Column(
        children: [
          _buildAddress(context),
          SpacerV(20),
          _buildPayment(context),
        ],
      )),
    ),
  );
}

Widget _buildAddress(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
    child: BlocBuilder<CheckoutBloc, CheckoutState>(
      buildWhen: (previous, current) => previous.addressStatus != current.addressStatus,
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Address",
                  style: TextStyle(color: MyColors.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    // BlocProvider.of<CheckoutBloc>(context).add(addAddressEvent(title: "home",address: "خیابان ایثارگران 22", icon: Icons.home));
                    addAddress(context);
                  },
                  child: const Text(
                    "Add Address",
                    style: TextStyle(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Container(
              height: 1,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(1), color: Colors.black12),
            ),
            for (var address in state.addresses)
              _buildAddressItem(
                  context, address.id, address.icon, address.title, address.address, address.isSelected!),

            // _buildAddressItem(Icons.local_post_office, "Office", "Chittagong, Bangladesh"),
          ],
        );
      },
    ),
  );
}

Widget _buildPayment(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
    child: BlocBuilder<CheckoutBloc, CheckoutState>(
      buildWhen: (previous, current) => previous.paymentStatus != current.paymentStatus,
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Payment",
                  style: TextStyle(color: MyColors.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    // BlocProvider.of<CheckoutBloc>(context).add(addAddressEvent(title: "home",address: "خیابان ایثارگران 22", icon: Icons.home));
                    addCard(context);
                  },
                  child: const Text(
                    "Add Card",
                    style: TextStyle(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Container(
              height: 1,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(1), color: Colors.black12),
            ),
            for (var paymentCard in state.paymentCards)
              _buildPaymentItem(context, paymentCard.id, paymentCard.icon, paymentCard.title,
                  paymentCard.card_number, paymentCard.isSelected!),
          ],
        );
      },
    ),
  );
}

Widget _buildAddressItem(
    BuildContext context, int id, IconData icon, String title, String text, bool isSelected) {
  return InkWell(
    onTap: () => BlocProvider.of<CheckoutBloc>(context).add(changeSelectedAddressEvent(id: id)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: MyColors.primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                      color: MyColors.primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Radio(
              value: id, // مقدار مربوط به این گزینه
              groupValue: isSelected == true ? id : 0, // شناسه گزینه انتخاب‌شده
              onChanged: (value) {
                if (value != null) {
                  BlocProvider.of<CheckoutBloc>(context).add(changeSelectedAddressEvent(id: value));
                }
              },
            )
          ],
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.black45, fontSize: 16),
        )
      ],
    ),
  );
}

Widget _buildPaymentItem(
    BuildContext context, int id, IconData icon, String title, String cardNumber, bool isSelected) {
  return InkWell(
    onTap: () => BlocProvider.of<CheckoutBloc>(context).add(changeSelectedPaymentCardEvent(id: id)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: MyColors.primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                      color: MyColors.primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Radio(
              value: id,
              groupValue: isSelected == true ? id : 0,
              onChanged: (value) {
                value == true
                    ? BlocProvider.of<CheckoutBloc>(context).add(changeSelectedPaymentCardEvent(id: id))
                    : null;
              },
            )
          ],
        ),
        Text(
          "**** **** **** ${cardNumber.substring(15)}",
          style: const TextStyle(color: Colors.black45, fontSize: 16),
        )
      ],
    ),
  );
}

Widget _buildTotalPrice(BuildContext context) {
  return Container(
    height: 120,
    color: MyColors.primaryBackgroundColor,
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        Center(
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Text(
                "Total Price \$${state.totalPrice}",
                style:
                    const TextStyle(color: MyColors.primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            BlocProvider.of<CheckoutBloc>(context).add(confirmCheckoutEvent());
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
                "Continue",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
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
