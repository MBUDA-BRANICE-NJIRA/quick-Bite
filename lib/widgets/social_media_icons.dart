import 'package:flutter/material.dart';

class SocialMediaIcons extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback onFacebookPressed;
  final VoidCallback onApplePressed;
  final double iconSize;
  final double buttonSize;

  const SocialMediaIcons({
    super.key,
    required this.onGooglePressed,
    required this.onFacebookPressed,
    required this.onApplePressed,
    this.iconSize = 28,
    this.buttonSize = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Google Button
        _buildSocialButton(
          icon: Icons.g_mobiledata,
          color: const Color(0xFFDB4437),
          onPressed: onGooglePressed,
        ),
        const SizedBox(width: 16),

        // Facebook Button
        _buildSocialButton(
          icon: Icons.facebook,
          color: const Color(0xFF4267B2),
          onPressed: onFacebookPressed,
        ),
        const SizedBox(width: 16),

        // Apple Button
        _buildSocialButton(
          icon: Icons.apple,
          color: Colors.black,
          onPressed: onApplePressed,
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: iconSize, color: color),
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
