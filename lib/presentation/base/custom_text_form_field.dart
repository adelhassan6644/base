import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/images.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hint;
  final Widget? sufWidget;
  final bool label;
  final TextInputType? type;
  final Function(String?)? onSave;
  final String? Function(String?)? valid;
  final AutovalidateMode? validationMode;
  final IconData? icon;
  final IconData? eIcon;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final String? sIcon;
  final String? tIcon;
  final Color? tIconColor;
  final FocusNode? focus;
  final bool? read;
  final bool? flag;
  final bool? removePIcon;
  final VoidCallback? edit;
  final bool? isEdit;

  final List<TextInputFormatter>? formatter;
  final double? hor;
  final int? maxLength;
  final Color? fieldColor;
  final int? maxLine;
  final bool isValidat;

  const CustomTextFormField({
    super.key,
    this.isValidat = true,
    this.maxLine = 1,
    this.hint,
    this.sufWidget,
    this.onSave,
    this.onTap,
    this.onChanged,
    this.icon,
    this.type,
    this.valid,
    this.controller,
    this.focus,
    this.sIcon,
    this.label = false,
    this.read,
    this.eIcon,
    this.edit,
    this.isEdit,
    this.removePIcon = true,
    this.flag,
    this.hor,
    this.validationMode,
    this.formatter,
    this.maxLength,
    this.tIcon,
    this.tIconColor,
    this.fieldColor,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isHidden = true;

  void _visibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: widget.isValidat ? [] : [const ShakeEffect()],
      child: TextFormField(
        onTap: widget.onTap,
        validator: widget.valid,
        controller: widget.controller,
        maxLength: widget.maxLength,
        focusNode: widget.focus,
        readOnly: widget.read == true ? true : false,
        maxLines: widget.maxLine,
        obscureText: widget.icon == Icons.lock_outline ? _isHidden : false,
        keyboardType: widget.type,
        inputFormatters: widget.formatter ?? [],
        onSaved: (widget.onSave),
        style: !widget.isValidat
            ? AppTextStyles.w400.copyWith(color: ColorResources.FAILED_COLOR)
            : AppTextStyles.w500.copyWith(
            color: ColorResources.PRIMARY_COLOR,
            fontSize: 14
        ),
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          prefixIcon: widget.removePIcon == true
              ? null
              : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: widget.tIcon != null
                ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: Image.asset(
                widget.tIcon!,
                height: 25.h,
                color: widget.tIconColor??ColorResources.DISABLED,
              ),
            )
                : null,
          ),
          suffixIcon: widget.removePIcon == true
              ? null : widget.icon == Icons.lock_outline
              ? IconButton(
            splashColor: Colors.transparent,
            onPressed: _visibility,
            alignment: Alignment.center,
            icon: _isHidden
                ?
            Image.asset(
                Images.eyeLockIcon,
                height: 25.h,
                color: ColorResources.DISABLED
            )
                : Image.asset(
              Images.unlockEyeLockIcon,
              color: ColorResources.PRIMARY_COLOR,
              height: 25.h,
            ),
          )
              : widget.sufWidget != null
              ? Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 25.w, horizontal: 25.w),
              child: widget.sufWidget)
              : Icon(
            widget.icon,
            color: Colors.grey,
            size: 20,
          ),
          focusedBorder:
          widget.read == true ?  const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.DISABLED,
                  width: 0
              )) : const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.PRIMARY_COLOR,
                  width: 0.5
              )),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0
          )),
          disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.DISABLED,
                  width: 0
              )),
          focusedErrorBorder:const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.FAILED_COLOR,
                  width: 0.5
              )),
          errorBorder:const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.FAILED_COLOR,
                  width: 0.5
              )),
          contentPadding: EdgeInsets.symmetric(
              vertical: 25.w, horizontal: widget.sufWidget != null ? 0 : 25.h),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0
              )),
          isDense: true,
          alignLabelWithHint: true,
          hintText: widget.hint,
          hintStyle: widget.isValidat ? AppTextStyles.w500.copyWith(
              color: ColorResources.HINT_COLOR,
              fontSize: 11
          ) : AppTextStyles.w500.copyWith(
              color: ColorResources.FAILED_COLOR,
              fontSize: 11
          ),
          labelText: widget.label ? widget.hint : null,
          fillColor: ColorResources.FILL_COLOR,
          floatingLabelStyle: widget.isValidat ? AppTextStyles.w500.copyWith(
              color: ColorResources.PRIMARY_COLOR,
              fontSize: 11
          ) : AppTextStyles.w500.copyWith(
              color: ColorResources.FAILED_COLOR,
              fontSize: 11
          ),
          filled: true,
          errorStyle: AppTextStyles.w500.copyWith(
            color: ColorResources.FAILED_COLOR,
            fontSize: 11
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20.h),
        ),
      ),
    );
  }
}