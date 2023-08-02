import 'dart:async';
import 'package:flutter/material.dart';

typedef Validate = String? Function(String? value);

enum InputType { number, pwd, verificationCode}

class InputTextFormField extends StatefulWidget {
  final TextEditingController textController;

  final ValueChanged? onChanged;

  final bool obscureText;

  /// placeholder
  final String hitText;

  /// 验证规则
  final Validate? validate;

  /// 错误信息
  final String? errorMsg;

  /// 键盘类型
  final InputType inputType;

  /// BorderRadius
  final double borderRadius;

  /// 边距
  final double contentPadding;

  /// 最大长度
  final int? maxLength;

  const InputTextFormField({
    Key? key,
    required this.textController,
    this.onChanged,
    this.obscureText = false,
    this.hitText = '',
    this.validate,
    this.errorMsg,
    this.inputType = InputType.number,
    this.borderRadius = 23.0,
    this.contentPadding = 20.0,
    this.maxLength
  }) : super(key: key);

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
  Timer? _timer;
  int _countdownSeconds = 0;
  final int _maxCountdownSeconds = 60;
  String currentText = '';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 69,
          child:  Stack(
            children: [
              Container(
                width: 328,
                height: 49,
                alignment: Alignment.center,
                child: TextFormField(
                  maxLength: widget.maxLength,
                  controller: widget.textController,
                  onChanged: (String value) {
                    setState(() {
                      currentText = value;
                    });

                    if (widget.onChanged != null) {
                      widget.onChanged!(value);
                    }
                  },
                  obscureText: widget.obscureText,
                  decoration: InputDecoration(
                    hintText: widget.hitText,
                    filled: true,
                    fillColor: const Color(0xFFF1F4F9),
                    hintStyle: const TextStyle(color: Color(0xFF969CA9)),
                    contentPadding: EdgeInsets.symmetric(horizontal: widget.contentPadding),
                    enabledBorder: OutlineInputBorder( // 设置非焦点状态下的边框样式
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      borderSide: const BorderSide(color: Color(0xFFF1F4F9)), // 设置非焦点状态下的边框颜色
                    ),
                    focusedBorder: OutlineInputBorder( // 设置焦点状态下的边框样式
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      borderSide: const BorderSide(color: Color(0xFFFF6415)), // 设置焦点状态下的边框颜色
                    ),
                    suffixIcon: widget.inputType == InputType.verificationCode ? verificationWidget() : otherSuffixIconWidget(),
                    errorStyle: const TextStyle(color: Colors.red),
                  ),
                  validator: widget.validate,
                ),
              ),
              if (widget.errorMsg?.isNotEmpty == true)
                Positioned(
                  top: 50,
                  child: Text(widget!.errorMsg as String, style: const TextStyle(color: Color(0xFFFF4D4F)),
                  ),
                )
            ],
          ),
        )
      ],
    );
  }

  // 获取验证码
  void _startCountDown() {
    setState(() {
      _countdownSeconds = _maxCountdownSeconds;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownSeconds > 0) {
          _countdownSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  // 验证码form样式
  Widget verificationWidget() {
    return GestureDetector(
      onTap: () {
        if (_countdownSeconds == 0) {
          _startCountDown();
        }
      },
      child: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentText.isNotEmpty == true)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: clearIconWidget(),
                  ),
                  const SizedBox(width: 10,),
                ],
              ),

            Visibility(
              visible: _countdownSeconds > 0,
              child: Text('再次获取${_countdownSeconds}s',  style: const TextStyle(color: Color(0xFFCCCCCC), fontSize: 16)),
            ),
            Visibility(
              visible: _countdownSeconds == 0,
              child: const Text('获取验证码', style: TextStyle(color: Color(0xFFFF6415), fontSize: 16),),
            )
          ],
        ),
      ),
    );
  }


  // 其他suffixIcon
  Widget? otherSuffixIconWidget () {
    if (currentText.isNotEmpty == true) {
      return clearIconWidget();
    }
    return null;
  }

  Widget clearIconWidget () {
    return GestureDetector(
      onTap: () {
        widget.textController.clear();
        setState(() {
          currentText = '';
        });
      },
      child: const Icon(Icons.cancel, color: Color(0xFFC1C5CD), size: 18,),
    );
  }
}
