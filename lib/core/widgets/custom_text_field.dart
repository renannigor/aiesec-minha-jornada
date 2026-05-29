import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; // <-- Novo import
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool enabled;
  final String? mask; // <-- Nova propriedade

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.mask, // <-- Nova propriedade
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  MaskTextInputFormatter? _maskFormatter; // <-- Controlador da máscara

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;

    // Inicializa a máscara se a string for fornecida
    if (widget.mask != null) {
      _maskFormatter = MaskTextInputFormatter(
        mask: widget.mask,
        filter: {"#": RegExp(r'[0-9]')}, // O '#' aceita apenas números
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mescla os formatadores de texto existentes com a nova máscara, se existir
    List<TextInputFormatter> currentFormatters = widget.inputFormatters != null
        ? List.from(widget.inputFormatters!)
        : [];

    if (_maskFormatter != null) {
      currentFormatters.add(_maskFormatter!);
    }

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      validator: widget.validator,
      inputFormatters: currentFormatters.isNotEmpty
          ? currentFormatters
          : null, // <-- Aplica aqui
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      enabled: widget.enabled,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: AppColors.textSecondary)
            : null,
        filled: true,
        fillColor: widget.enabled
            ? AppColors.backgroundWhite
            : AppColors.backgroundLight,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.borderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: AppColors.borderFocus,
            width: 2.0,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.borderDefault),
        ),

        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.suffixIcon,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
      ),
    );
  }
}
