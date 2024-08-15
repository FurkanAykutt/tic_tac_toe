import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/navigation.dart';
import '../widgets/app_button.dart';
import '../widgets/app_input_field.dart';
import '../widgets/app_screen.dart';
import '../widgets/heading.dart';
import 'title_screen.dart';

class EntryNameScreen extends StatelessWidget {
  final _nicknameController = TextEditingController();

  EntryNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Heading(text: 'Choose nickname'),
          AppInputField(controller: _nicknameController),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Play',
                  onPressed: () {
                    _saveNickname();
                    switchScreen(
                        context,
                        TitleScreen(
                          nickname: _nicknameController.text,
                        ));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Kullanıcı adını kaydetme
  void _saveNickname() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', _nicknameController.text);
  }
}
