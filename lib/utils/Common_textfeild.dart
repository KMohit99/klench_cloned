import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';

class CommonTextFormField_text extends StatelessWidget {
  final String title;
  final String? labelText;
  final TextEditingController? controller;
  final String? trailingImagePath;
  final TextInputType? keyboardType;
  final bool? isObscure;
  final bool? isMobileTextField;
  final Color? color;
  final int? maxLines;
  final double? height;
  final GestureTapCallback? tap;
  final bool? readOnly;
  final IconButton? iconData;
  final TextAlign? align;
  FormFieldValidator<String>? validator;

  final Function(String)? onChanged;
  final bool? enabled;
  final bool? touch = false;

  CommonTextFormField_text({
    Key? key,
    this.onChanged,
    required this.title,
    this.labelText,
    this.controller,
    this.trailingImagePath,
    this.keyboardType,
    this.isObscure = false,
    this.isMobileTextField = false,
    this.color,
    this.maxLines,
    this.tap,
    this.readOnly,
    this.align,
    this.validator,
    this.enabled,
    this.height,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 45,right: 45.93),
      margin: const EdgeInsets.symmetric(horizontal: 0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 18),
            child: Text(title,
                style: FontStyleUtility.h15(
                    fontColor: HexColor('#9F9F9F'), family: 'PM')),
          ),
          SizedBox(
            height: 11,
          ),
          Container(
            // width: 300,
            decoration: BoxDecoration(
              // color: Colors.black.withOpacity(0.65),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  // stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    HexColor("#36393E").withOpacity(1),
                    HexColor("#020204").withOpacity(1),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: HexColor('#04060F'),
                    offset: Offset(10, 10),
                    blurRadius: 20,
                  ),
                ],
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              maxLength: 150,
              onChanged: onChanged,
              enabled: enabled,
              validator: validator,
              maxLines: maxLines,
              onTap: tap,
              obscureText: isObscure ?? false,
              decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.only(left: 20, top: 14, bottom: 14),
                  alignLabelWithHint: false,
                  isDense: true,
                  hintText: labelText ?? '',
                  counterStyle: TextStyle(
                    height: double.minPositive,
                  ),
                  counterText: "",
                  filled: true,
                  border: InputBorder.none,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintStyle: FontStyleUtility.h15(
                      fontColor: ColorUtils.primary_grey, family: 'PM'),
                  suffixIcon: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.65),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            // stops: [0.1, 0.5, 0.7, 0.9],
                            colors: [
                              HexColor("#020204").withOpacity(1),
                              HexColor("#36393E").withOpacity(1),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: HexColor('#04060F'),
                              offset: Offset(3, 3),
                              blurRadius: 20,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(50)),
                      child: iconData)),
              style: FontStyleUtility.h15(
                  fontColor: ColorUtils.primary_gold, family: 'PM'),
              controller: controller,
              keyboardType: keyboardType ?? TextInputType.multiline,
            ),
          ),
        ],
      ),
    );
  }
}

class CommonTextFormField_text_reversed extends StatelessWidget {
  final String title;
  final String? labelText;
  final TextEditingController? controller;
  final String? trailingImagePath;
  final TextInputType? keyboardType;
  final bool? isObscure;
  final bool? isMobileTextField;
  final Color? color;
  final int? maxLines;
  final double? height;
  final GestureTapCallback? tap;
  final bool? readOnly;
  final IconButton? iconData;
  final TextAlign? align;
  FormFieldValidator<String>? validator;

  final Function(String)? onChanged;
  final bool? enabled;
  final bool? touch = false;

  CommonTextFormField_text_reversed({
    Key? key,
    this.onChanged,
    required this.title,
    this.labelText,
    this.controller,
    this.trailingImagePath,
    this.keyboardType,
    this.isObscure,
    this.isMobileTextField = false,
    this.color,
    this.maxLines,
    this.tap,
    this.readOnly,
    this.align,
    this.validator,
    this.enabled,
    this.height,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 45,right: 45.93),
      margin: const EdgeInsets.symmetric(horizontal: 0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 0),
            child: Text(title,
                style: FontStyleUtility.h15(
                    fontColor: HexColor('#9F9F9F'), family: 'PM')),
          ),
          SizedBox(
            height: 11,
          ),
          Container(
            // width: 300,
            decoration: BoxDecoration(
              // color: Colors.black.withOpacity(0.65),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  // stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    HexColor("#020204").withOpacity(1),
                    HexColor("#36393E").withOpacity(1),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: HexColor('#04060F'),
                    offset: Offset(10, 10),
                    blurRadius: 20,
                  ),
                ],
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              maxLength: 150,
              onChanged: onChanged,
              enabled: enabled,
              validator: validator,
              maxLines: maxLines,
              onTap: tap,
              obscureText: isObscure ?? false,
              decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.only(left: 20, top: 14, bottom: 14),
                  alignLabelWithHint: false,
                  isDense: true,
                  hintText: labelText ?? '',
                  counterStyle: TextStyle(
                    height: double.minPositive,
                  ),
                  counterText: "",
                  filled: true,
                  border: InputBorder.none,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintStyle: FontStyleUtility.h15(
                      fontColor: ColorUtils.primary_grey, family: 'PM'),
                  suffixIcon: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.65),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            // stops: [0.1, 0.5, 0.7, 0.9],
                            colors: [
                              HexColor("#020204").withOpacity(1),
                              HexColor("#36393E").withOpacity(1),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: HexColor('#04060F'),
                              offset: Offset(3, 3),
                              blurRadius: 20,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(50)),
                      child: iconData)),
              style: FontStyleUtility.h15(
                  fontColor: ColorUtils.primary_gold, family: 'PM'),
              controller: controller,
              keyboardType: keyboardType ?? TextInputType.multiline,
            ),
          ),
        ],
      ),
    );
  }
}

class CommonTextFormField extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final String? trailingImagePath;
  final TextInputType? keyboardType;
  final bool? isObscure;
  final bool? isMobileTextField;
  final int? maxLines;
  final double? height;
  final GestureTapCallback? tap;
  final bool? readOnly;
  final IconButton? iconData;
  final TextAlign? align;
  final FocusNode? textFocusNode;
  final int? maxLength;
  final ValueChanged? onFieldSubmitted;

  FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final bool? enabled;
  final bool? touch = false;

  CommonTextFormField({
    Key? key,
    this.onChanged,
    this.labelText,
    this.controller,
    this.trailingImagePath,
    this.keyboardType,
    this.isObscure = false,
    this.isMobileTextField = false,
    this.maxLines,
    this.tap,
    this.readOnly,
    this.align,
    this.validator,
    this.enabled,
    this.height,
    this.iconData,
    this.textFocusNode, this.onFieldSubmitted, this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 45,right: 45.93),
      margin: const EdgeInsets.symmetric(horizontal: 0),

      child: Container(
        // height: 50,
        // width: 300,
        decoration: BoxDecoration(
          // color: Colors.black.withOpacity(0.65),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              // stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                HexColor("#36393E").withOpacity(1),
                HexColor("#020204").withOpacity(1),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: HexColor('#04060F'),
                offset: Offset(10, 10),
                blurRadius: 20,
              ),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          maxLength: maxLength,
          onChanged: onChanged,
          enabled: enabled,
          validator: validator,
          maxLines: maxLines,
          onTap: tap,
          readOnly: (readOnly ?? false),
          obscureText: isObscure ?? false,
          scrollPhysics: ClampingScrollPhysics(),
          focusNode: textFocusNode,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
              alignLabelWithHint: false,
              isDense: true,
              hintText: labelText ?? '',
              counterStyle: TextStyle(
                height: double.minPositive,
              ),
              counterText: "",
              filled: true,
              border: InputBorder.none,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              hintStyle: FontStyleUtility.h15(
                  fontColor: ColorUtils.primary_grey, family: 'PM'),
              suffixIcon: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.65),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        // stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          HexColor("#020204").withOpacity(1),
                          HexColor("#36393E").withOpacity(1),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor('#04060F'),
                          offset: Offset(3, 3),
                          blurRadius: 20,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50)),
                  child: iconData)),
          style: FontStyleUtility.h15(
              fontColor: ColorUtils.primary_gold, family: 'PM'),
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.multiline,
        ),
      ),
    );
  }
}

class CommonTextFormField_reversed extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final String? trailingImagePath;
  final TextInputType? keyboardType;
  final bool? isObscure;
  final bool? isMobileTextField;
  final int? maxLines;
  final double? height;
  final GestureTapCallback? tap;
  final bool? readOnly;
  final IconButton? iconData;
  final TextAlign? align;
  FormFieldValidator<String>? validator;

  final Function(String)? onChanged;
  final bool? enabled;
  final bool? touch = false;
  final FocusNode? textFocusNode;
  final ValueChanged? onFieldSubmitted;

  CommonTextFormField_reversed({
    Key? key,
    this.onChanged,
    this.labelText,
    this.controller,
    this.trailingImagePath,
    this.keyboardType,
    this.isObscure = false,
    this.isMobileTextField = false,
    this.maxLines,
    this.tap,
    this.readOnly,
    this.align,
    this.validator,
    this.enabled,
    this.height,
    this.iconData, this.textFocusNode, this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 45,right: 45.93),
      margin: const EdgeInsets.symmetric(horizontal: 0),

      child: Container(
        height: 50,
        // width: 300,
        decoration: BoxDecoration(
          // color: Colors.black.withOpacity(0.65),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              // stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                HexColor("#020204").withOpacity(1),
                HexColor("#36393E").withOpacity(1),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: HexColor('#04060F'),
                offset: Offset(10, 10),
                blurRadius: 20,
              ),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          maxLength: 150,
          onChanged: onChanged,
          enabled: enabled,
          validator: validator,
          maxLines: maxLines,
          onTap: tap,
          readOnly: (readOnly ?? false),
          obscureText: isObscure ?? false,
          focusNode: textFocusNode,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
              alignLabelWithHint: false,
              isDense: true,
              hintText: labelText ?? '',
              counterStyle: TextStyle(
                height: double.minPositive,
              ),
              counterText: "",
              filled: true,
              border: InputBorder.none,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              hintStyle: FontStyleUtility.h15(
                  fontColor: ColorUtils.primary_grey, family: 'PM'),
              suffixIcon: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.65),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        // stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          HexColor("#36393E").withOpacity(1),
                          HexColor("#020204").withOpacity(1),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor('#04060F'),
                          offset: Offset(3, 3),
                          blurRadius: 20,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50)),
                  child: iconData)),
          style: FontStyleUtility.h15(
            fontColor: ColorUtils.primary_gold,
            family: 'PM',
          ),
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.multiline,
        ),
      ),
    );
  }
}

class CommonTextFormField_noicon extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final String? trailingImagePath;
  final TextInputType? keyboardType;
  final bool? isObscure;
  final bool? isMobileTextField;
  final int? maxLines;
  final double? height;
  final GestureTapCallback? tap;
  final bool? readOnly;
  final IconButton? iconData;
  final TextAlign? align;
  FormFieldValidator<String>? validator;

  final Function(String)? onChanged;
  final bool? enabled;
  final bool? touch = false;

  CommonTextFormField_noicon({
    Key? key,
    this.onChanged,
    this.labelText,
    this.controller,
    this.trailingImagePath,
    this.keyboardType,
    this.isObscure = false,
    this.isMobileTextField = false,
    this.maxLines,
    this.tap,
    this.readOnly,
    this.align,
    this.validator,
    this.enabled,
    this.height,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 45,right: 45.93),
      margin: const EdgeInsets.symmetric(horizontal: 0),

      child: Container(
        height: 50,
        // width: 300,
        decoration: BoxDecoration(
          // color: Colors.black.withOpacity(0.65),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              // stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                HexColor("#36393E").withOpacity(1),
                HexColor("#020204").withOpacity(1),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: HexColor('#04060F'),
                offset: Offset(10, 10),
                blurRadius: 20,
              ),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          maxLength: 150,
          onChanged: onChanged,
          enabled: enabled,
          validator: validator,
          maxLines: maxLines,
          onTap: tap,
          readOnly: (readOnly ?? false),
          obscureText: isObscure ?? false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
            alignLabelWithHint: false,
            isDense: true,
            hintText: labelText ?? '',
            counterStyle: TextStyle(
              height: double.minPositive,
            ),
            counterText: "",
            filled: true,
            border: InputBorder.none,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            hintStyle: FontStyleUtility.h15(
                fontColor: ColorUtils.primary_grey, family: 'PM'),
          ),
          style: FontStyleUtility.h15(
              fontColor: ColorUtils.primary_gold, family: 'PM'),
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.multiline,
        ),
      ),
    );
  }
}
