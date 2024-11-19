import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/application_notifier.dart';
import '../provider/current_menu_notifer.dart';
import '../service/debug_logger.dart';
import '../shared/custom_navigator.dart';
import '../shared/custom_text.dart';
import '../shared/responsiveness.dart';
import '../shared/route.dart';
import '../shared/style.dart';

class ApplicationPage extends ConsumerWidget {
  ApplicationPage({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "ApplicationPage";
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final churchController = TextEditingController();
  final yearInHIMController = TextEditingController();
  final yearInBaptistController = TextEditingController();
  final churchServiceController = TextEditingController();
  final yearInChurchChoirController = TextEditingController();
  final otherChoirController = TextEditingController();
  final yearInOtherChoirController = TextEditingController();
  final partController = TextEditingController();
  final musicTalentController = TextEditingController();
  final otherTalentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _applicationTest(context),
          _applicationButton(ref),
        ],
      ),
    );
  }

  Widget _applicationTest(BuildContext context) {
    List<Widget> basicInfo = [];
    List<Widget> churchInfo = [];
    List<Widget> choirInfo = [];
    basicInfo.add(
      CustomTextFeildInput(
        customController: nameController,
        customHintText: "姓名",
        customIcon: const Icon(Icons.person),
        isRequired: true,
      ),
    );
    basicInfo.add(
      CustomPhoneFeildInput(
        customController: phoneController,
        customHintText: "聯絡電話",
        customIcon: const Icon(Icons.phone),
      ),
    );
    basicInfo.add(
      CustomEmailFeildInput(
        customController: emailController,
        customHintText: "電郵",
        customIcon: const Icon(Icons.email),
      ),
    );
    basicInfo.add(
      CustomGenderFeildInput(
        customController: genderController,
        customHintText: "性別",
        customIcon: const Icon(Icons.person_search),
      ),
    );
    churchInfo.add(
      CustomTextFeildInput(
        customController: churchController,
        customHintText: "所屬教會",
        customIcon: const Icon(Icons.people_rounded),
        isRequired: true,
      ),
    );
    churchInfo.add(
      CustomNumberFeildInput(
        customController: yearInHIMController,
        customHintText: "信主年齡",
        customIcon: const Icon(Icons.trending_up),
        isRequired: true,
      ),
    );
    churchInfo.add(
      CustomNumberFeildInput(
        customController: yearInBaptistController,
        customHintText: "接受浸禮年份",
        customIcon: const Icon(Icons.water),
        isRequired: true,
      ),
    );
    churchInfo.add(
      CustomTextFeildInput(
        customController: churchServiceController,
        customHintText: "教會事奉經驗",
        customIcon: const Icon(Icons.miscellaneous_services),
        isRequired: false,
      ),
    );
    choirInfo.add(
      CustomNumberFeildInput(
        customController: yearInChurchChoirController,
        customHintText: "教會詩班年齡",
        customIcon: const Icon(Icons.verified),
        isRequired: false,
      ),
    );
    choirInfo.add(
      CustomTextFeildInput(
        customController: otherChoirController,
        customHintText: "參加其他合唱團名稱",
        customIcon: const Icon(Icons.near_me),
        isRequired: false,
      ),
    );
    choirInfo.add(
      CustomNumberFeildInput(
        customController: yearInOtherChoirController,
        customHintText: "其他合唱團詩班年齡",
        customIcon: const Icon(Icons.mouse_rounded),
        isRequired: false,
      ),
    );
    choirInfo.add(
      CustomPartsFieldInput(
        customController: partController,
        customHintText: "聲部",
        customIcon: const Icon(Icons.person_search),
      ),
    );
    choirInfo.add(
      CustomTextFeildInput(
        customController: musicTalentController,
        customHintText: "音樂專長（指揮/樂器）",
        customIcon: const Icon(Icons.piano),
        isRequired: false,
      ),
    );
    choirInfo.add(
      CustomTextFeildInput(
        customController: otherTalentController,
        customHintText: "其他專長",
        customIcon: const Icon(Icons.work_sharp),
        isRequired: false,
      ),
    );
    Widget basicInfoWidget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: basicInfo,
      ),
    );
    Widget churchInfoWidget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: churchInfo,
      ),
    );
    Widget choirInfoWidget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: choirInfo,
      ),
    );
    return Form(
      key: _formKey,
      child: ResponsiveWidget.isiPadScreen(context)
          ? Column(
              children: [
                basicInfoWidget,
                churchInfoWidget,
                choirInfoWidget,
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: basicInfoWidget),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(child: churchInfoWidget),
                  ],
                ),
                choirInfoWidget,
              ],
            ),
    );
  }

  Widget _applicationButton(WidgetRef ref) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Map<dynamic, dynamic> data = {
                "name": nameController.text.toString(),
                "phone": phoneController.text.toString(),
                "email": emailController.text.toString(),
                "gender": genderController.text.toString(),
                "church": churchController.text.toString(),
                "yearInHIM": yearInHIMController.text.toString(),
                "yearInBaptist": yearInBaptistController.text.toString(),
                "churchService": churchServiceController.text.toString(),
                "yearInChurchChoir":
                    yearInChurchChoirController.text.toString(),
                "otherChoir": otherChoirController.text.toString(),
                "yearInOtherChoir": yearInOtherChoirController.text.toString(),
                "part": partController.text.toString(),
                "musicTalent": musicTalentController.text.toString(),
                "otherTalent": otherTalentController.text.toString(),
              };
              ref
                  .read(applicationNotifierProvider.notifier)
                  .createDocument(data);
              ref.read(currentMenuStateProvider.notifier).update(0);
              ref.read(activeItem.notifier).state = defaultPageDisplayName;
              ref
                  .read(navigatorKeyStateProvider)
                  .currentState!
                  .pushNamed(sideMenuItemRoutes[0].route);
            }
          },
          child: CustomText(
              text: '電郵給我們',
              size: standardTextSize,
              color: dark,
              weight: FontWeight.normal),
        ),
      );
}

InputDecoration customInputDecoration(
        String customHintText, BuildContext context) =>
    InputDecoration(
      hintText: customHintText,
      hintStyle: TextStyle(
          fontFamily: defaultFont,
          fontSize: ResponsiveWidget.isSmallScreen(context)
              ? 16
              : ResponsiveWidget.isMediumScreen(context)
                  ? 18
                  : 24, // default is 16,
          color: dark, // default is Colors.black,
          fontWeight: FontWeight.normal),
      errorStyle: TextStyle(
          fontFamily: defaultFont,
          fontSize: ResponsiveWidget.isSmallScreen(context)
              ? 16
              : ResponsiveWidget.isMediumScreen(context)
                  ? 18
                  : 24, // default is 16,
          color: Colors.red, // default is Colors.black,
          fontWeight: FontWeight.normal),
    );

EdgeInsets customFormEdgeInsets() =>
    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0);

class CustomTextFeildInput extends StatelessWidget {
  const CustomTextFeildInput({
    super.key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
    required this.isRequired,
  });

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: customIcon,
        title: TextFormField(
          style: TextStyle(fontFamily: defaultFont),
          validator: (value) {
            if (isRequired) {
              if (value == null || value.isEmpty) {
                return '請輸入資料';
              }
            }
            return null;
          },
          controller: customController,
          decoration: customInputDecoration(customHintText, context),
        ),
      ),
    );
  }
}
//https://protocoderspoint.com/flutter-form-validation-email-validate-password-confirm/

class CustomEmailFeildInput extends StatelessWidget {
  const CustomEmailFeildInput({
    super.key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
  });

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: customIcon,
        title: TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '請輸入資料';
            }
            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                .hasMatch(value)) {
              return '請輸入有效的電郵地址';
            }
            return null;
          },
          controller: customController,
          decoration: customInputDecoration(customHintText, context),
        ),
      ),
    );
  }
}

class CustomPasswordFeildInput extends StatelessWidget {
  const CustomPasswordFeildInput({
    super.key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
  });

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: customIcon,
        title: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '請輸入';
            }
            if (value.length < 8) {
              return '密碼必須至少為 8 個字符';
            }
            return null;
          },
          controller: customController,
          decoration: customInputDecoration(customHintText, context),
        ),
      ),
    );
  }
}

class CustomConfirmedPasswordFeildInput extends StatelessWidget {
  const CustomConfirmedPasswordFeildInput({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.customHintText,
    required this.customIcon,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String customHintText;
  final Icon customIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: customIcon,
        title: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '請輸入';
            }
            if (confirmPasswordController.text != passwordController.text) {
              return '密碼和確認密碼不同';
            }
            return null;
          },
          controller: confirmPasswordController,
          decoration: customInputDecoration(customHintText, context),
        ),
      ),
    );
  }
}

class CustomGenderFeildInput extends StatefulWidget {
  const CustomGenderFeildInput({
    super.key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
  });

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;

  @override
  State<CustomGenderFeildInput> createState() => _CustomGenderFeildInputState();
}

class _CustomGenderFeildInputState extends State<CustomGenderFeildInput> {
  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => widget.customController.text = value!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: widget.customIcon,
        title: Row(
          children: [
            MyRadioOption<String>(
              value: 'M',
              groupValue: widget.customController.text,
              onChanged: _valueChangedHandler(),
              label: '男',
              text: '男',
            ),
            MyRadioOption<String>(
              value: 'F',
              groupValue: widget.customController.text,
              onChanged: _valueChangedHandler(),
              label: '女',
              text: '女',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomPartsFieldInput extends StatefulWidget {
  const CustomPartsFieldInput({
    super.key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
  });

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;

  @override
  State<CustomPartsFieldInput> createState() => _CustomPartsFieldInputState();
}

class _CustomPartsFieldInputState extends State<CustomPartsFieldInput> {
  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => widget.customController.text = value!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: widget.customIcon,
        title: Column(
          children: [
            Row(
              children: [
                MyRadioOption<String>(
                  value: 'S',
                  groupValue: widget.customController.text,
                  onChanged: _valueChangedHandler(),
                  label: '女高',
                  text: '女高',
                ),
                MyRadioOption<String>(
                  value: 'A',
                  groupValue: widget.customController.text,
                  onChanged: _valueChangedHandler(),
                  label: '女低',
                  text: '女低',
                ),
              ],
            ),
            Row(
              children: [
                MyRadioOption<String>(
                  value: 'T',
                  groupValue: widget.customController.text,
                  onChanged: _valueChangedHandler(),
                  label: '男高',
                  text: '男高',
                ),
                MyRadioOption<String>(
                  value: 'B',
                  groupValue: widget.customController.text,
                  onChanged: _valueChangedHandler(),
                  label: '男低',
                  text: '男低',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNumberFeildInput extends StatelessWidget {
  const CustomNumberFeildInput({
    super.key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
    required this.isRequired,
  });

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: customIcon,
        title: TextFormField(
          keyboardType: TextInputType.number,
          validator: (value) {
            if ((isRequired) && (value == null || value.isEmpty)) {
              return '請輸入資料';
            }
            final n = num.tryParse(value!);
            if ((value.isNotEmpty) && (n == null)) {
              return '請輸入數字';
            }
            return null;
          },
          controller: customController,
          decoration: customInputDecoration(customHintText, context),
        ),
      ),
    );
  }
}

class CustomPhoneFeildInput extends StatelessWidget {
  const CustomPhoneFeildInput({
    super.key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
  });

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: customIcon,
        title: TextFormField(
          keyboardType: TextInputType.number,
          validator: (value) {
            String pattern = r'(^[2-9][0-9]{7}$)';
            if (value == null || value.isEmpty) {
              return '請輸入資料';
            }
            final n = num.tryParse(value);
            if (n == null) {
              return '請輸入數字';
            }
            if ((!RegExp(pattern).hasMatch(value))) {
              return '請輸入有效的電話號碼';
            }
            return null;
          },
          controller: customController,
          decoration: customInputDecoration(customHintText, context),
        ),
      ),
    );
  }
}

class MyRadioOption<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final String text;
  final ValueChanged<T?> onChanged;

  const MyRadioOption({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.text,
    required this.onChanged,
  });

  Widget _buildLabel(BuildContext context) {
    final bool isSelected = value == groupValue;

    return Container(
      width: ResponsiveWidget.isSmallScreen(context)
          ? 27
          : ResponsiveWidget.isMediumScreen(context)
              ? 29
              : 36,
      height: ResponsiveWidget.isSmallScreen(context)
          ? 27
          : ResponsiveWidget.isMediumScreen(context)
              ? 29
              : 36,
      decoration: ShapeDecoration(
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
        ),
        color: isSelected ? Colors.cyan : Colors.white,
      ),
      child: Center(
          child: CustomText(
              text: value.toString(),
              size: standardTextSize,
              color: isSelected ? Colors.white : dark,
              weight: FontWeight.normal)
          //Text(
          //  value.toString(),
          //  style: TextStyle(
          //    fontFamily: defaultFont,
          //    color: isSelected ? Colors.white : dark,
          //    fontSize: ResponsiveWidget.isSmallScreen(context)
          //        ? 14
          //        : ResponsiveWidget.isMediumScreen(context)
          //            ? 16
          //            : 22,
          //  ),
          //),
          ),
    );
  }

  Widget _buildText(BuildContext context) {
    return CustomText(
        text: text,
        size: standardTextSize,
        color: Colors.black,
        weight: FontWeight.normal);
    //Text(
    //  text,
    //  style: TextStyle(
    //    fontFamily: defaultFont,
    //    color: Colors.black,
    //    fontSize: ResponsiveWidget.isSmallScreen(context)
    //        ? 16
    //        : ResponsiveWidget.isMediumScreen(context)
    //            ? 18
    //            : 24,
    //  ),
    //);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => onChanged(value),
        splashColor: Colors.cyan.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              _buildLabel(context),
              const SizedBox(width: 10),
              _buildText(context),
            ],
          ),
        ),
      ),
    );
  }
}
