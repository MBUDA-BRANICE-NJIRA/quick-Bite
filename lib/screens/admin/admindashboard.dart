import 'package:flutter/material.dart';
import '../../widgets/title_widget.dart';

class AdminHomeScreen extends StatelessWidget {
  static const routeName = '/Admindashboard';
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SubtitleTextWidget(label: 'Dashboard')),
    );
  }
}
