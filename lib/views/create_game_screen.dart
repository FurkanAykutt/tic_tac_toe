import 'package:flutter/material.dart';

import '../services/services.dart';
import '../widgets/app_button.dart';
import '../widgets/app_input_field.dart';
import '../widgets/app_screen.dart';
import '../widgets/screen_loader.dart';
import 'game/host_game_view.dart';

class CreateGameScreen extends StatefulWidget {
  const CreateGameScreen({super.key});

  @override
  _CreateGameScreenState createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends State<CreateGameScreen> {
  Color selectedColor = Colors.red;
  final TextEditingController _gameNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Oyun adı girişi
            const Text('Enter game name'),
            AppInputField(
              controller: _gameNameController,
            ),
            const SizedBox(height: 20),
            // Renk seçenekleri
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _colorOption(Colors.red, "Red"),
                _colorOption(Colors.blue, "Blue"),
                _colorOption(Colors.purple, "Purple"),
              ],
            ),
            const SizedBox(height: 20),
            // Create button
            AppButton.expanded(
              label: 'Create game',
              onPressed: () async {
                if (_gameNameController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ScreenLoader(
                        future: Services.of(context).gameService.newGame(
                            _gameNameController.text,
                            selectedColor), // game creation logic can be modified to include the game name and color
                        builder: (context, game) => HostGameView(
                          game: game,
                          gameService: Services.of(context).gameService,
                        ),
                      ),
                    ),
                  );
                } else {
                  // Oyun adı boşsa uyarı gösterebilirsiniz
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a game name')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Renk seçeneği widget'ı
  Widget _colorOption(Color color, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    selectedColor == color ? Colors.white : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: selectedColor == color ? color : Colors.white,
              fontWeight:
                  selectedColor == color ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
