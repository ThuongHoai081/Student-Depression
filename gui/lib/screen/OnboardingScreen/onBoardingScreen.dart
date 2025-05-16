import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gui/screen/HomeScreen/homeScreens.dart';
import 'package:gui/screen/OnboardingScreen/widget/buildWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gui/common/theme.dart';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({super.key});

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  final PageController _controller = PageController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_controller.page == 3) {
        _controller.jumpToPage(0);
      } else {
        _controller.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              buildPage(
                title: "Chào mừng bạn đến với",
                subtitle: "DepressCare",
                description1: "🧠 Ứng dụng hỗ trợ phát hiện trầm cảm",
                description2: "📊 Đánh giá dựa trên dữ liệu chính xác",
                description3: "💬 Hỗ trợ tư vấn và chăm sóc sức khỏe tâm thần",
                description4: "❤️ Giúp bạn lấy lại cân bằng cuộc sống",
                backgroundWidget:
                    Image.asset("images/im.jpg", fit: BoxFit.cover),
              ),
              buildPage(
                title: "Tính năng nổi bật",
                subtitle: "Hỗ trợ bạn mọi lúc mọi nơi",
                description1: "📝 Câu hỏi đánh giá trầm cảm chuẩn PHQ-9",
                description2: "📈 Phân tích và dự đoán nguy cơ trầm cảm",
                description3: "💡 Gợi ý phương pháp cải thiện tâm trạng",
                description4: "🤝 Kết nối với chuyên gia tâm lý khi cần",
                backgroundWidget:
                    Image.asset("images/image.png", fit: BoxFit.cover),
              ),
              buildPage(
                title: "Lợi ích khi sử dụng",
                subtitle: "Chăm sóc sức khỏe tâm thần hiệu quả",
                description1: "⏳ Tiết kiệm thời gian khám sàng lọc",
                description2: "🔍 Phát hiện sớm các dấu hiệu trầm cảm",
                description3: "📚 Tăng nhận thức và hiểu biết về tâm lý",
                description4: "🌱 Hỗ trợ tinh thần phát triển tích cực",
                backgroundWidget:
                    Image.asset("images/im3.jpg", fit: BoxFit.cover),
              ),
              buildPage(
                title: "Hướng dẫn sử dụng",
                subtitle: "Chỉ vài bước đơn giản",
                description1: "🖊 Trả lời bộ câu hỏi đánh giá trầm cảm",
                description2: "⏳ Đợi kết quả phân tích tự động",
                description3: "💬 Nhận tư vấn và gợi ý hỗ trợ phù hợp",
                description4: "🚀 Bắt đầu hành trình chăm sóc bản thân!",
                backgroundWidget:
                    Image.asset("images/im4.jpg", fit: BoxFit.cover),
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.primary,
                  dotColor: AppColors.dotInactive,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  _timer.cancel();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text("Bắt đầu", style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
