import 'package:flutter/material.dart'; // Đảm bảo bạn có định nghĩa blackColor ở đây

class CustomButton extends StatelessWidget {
  final String textButton;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.textButton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style:  ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50) , backgroundColor  : Colors.blue ),
      child: Text(
        textButton,
        style: const TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.w400), // Xóa const ở đây
      ),
    );
  }
}
