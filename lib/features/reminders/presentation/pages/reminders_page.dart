import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Needed for the Time Picker
import '../../../home/presentation/pages/home_screen.dart';
import '../../../../core/constants/app_colors.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  // State for the day selectors
  final List<bool> _selectedDays = [
    false,
    true,
    false,
    false,
    false,
    false,
    false,
  ];
  final List<String> _days = ['SU', 'M', 'T', 'W', 'TH', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              // 1. Top Heading
              Text(
                'What time would you\nlike to meditate?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),

              // 2. Subtitle
              Text(
                'Any time you can choose but We recommend first thing in th morning.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.w300,
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),

              // 3. Time Picker Card
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.backgroundGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontSize: 24,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (DateTime newTime) {
                      // Handle time change
                    },
                    use24hFormat: false,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 4. Day Selection Heading
              Text(
                'Which day would you\nlike to meditate?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),

              // 5. Day Selection Subtitle
              Text(
                'Everyday is best, but we recommend picking at least five.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.w300,
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),

              // 6. Day Bubbles Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_days.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDays[index] = !_selectedDays[index];
                      });
                    },
                    child: _DayBubble(
                      label: _days[index],
                      isSelected: _selectedDays[index],
                    ),
                  );
                }),
              ),

              // Pushes buttons to bottom
              const Spacer(),

              // 7. Save Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      color: AppColors.textWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // 8. No Thanks Button
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'NO THANKS',
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Widget for the circular day buttons
class _DayBubble extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _DayBubble({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.primaryDark : AppColors.backgroundWhite,
        border: Border.all(
          color: isSelected ? Colors.transparent : const Color(0x809E9E9E),
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            color: isSelected ? AppColors.textWhite : AppColors.textSecondary,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
