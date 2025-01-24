import 'package:flutter/material.dart';
import 'package:planus/views/login_screen.dart';
import 'package:provider/provider.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import '../components/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFDF3E7),
        body: Column(
          children: [
            Expanded(
              child: Consumer<OnboardingViewModel>(
                builder: (context, viewModel, _) {
                  return PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      viewModel.updatePage(index);
                    },
                    children: [
                      _buildPage(
                        context,
                        image: 'assets/study_plan.png', // 2번째 페이지 이미지
                        title: '学習プランや読書プラン',
                        description: '自分のプランを立ててみんなに共有しましょう',
                      ),
                      _buildPage(
                        context,
                        image: 'assets/goal_achievement.png', // 3번째 페이지 이미지
                        title: '自分のゴールを達成しよう',
                        description: '達成したゴールをみんなに褒めてもらおう',
                      ),
                    ],
                  );
                },
              ),
            ),
            Consumer<OnboardingViewModel>(
              builder: (context, viewModel, _) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CustomButton(
                    text: viewModel.currentPage == 0 ? '次へ' : 'スタート',
                    onPressed: () {
                      if (viewModel.currentPage == 0) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context,
      {required String image,
      required String title,
      required String description}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200), // 이미지 표시
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
