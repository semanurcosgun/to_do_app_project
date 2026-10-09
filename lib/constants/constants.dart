import 'package:flutter/material.dart';

class Constants {
  static const Color pastelPink = Color(0xFFFBE7F0);

  static const Color pastelPurple = Color(0xFFF3EDFF);

  static const Color pastelCream = Color(0xFFFFF1DE);

  static const Color pastelGreen = Color(0xFFF7F9EE);

  static const Color darkText = Color(0xFF5D4054);

  static const Color primaryPink = Color(0xFFDDA8C8);
  static TextStyle getTitleTextStyle() {
    return TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: "PinyonScript",
      fontSize: 24,
    );
  }

  static TextStyle completedTaskTextStyle() {
    return TextStyle(
      decoration: TextDecoration.lineThrough,
      color: Colors.grey,
      fontFamily: "PinyonScript",
    );
  }

  static TextStyle taskTimeTextStyle() {
    return TextStyle(
      fontSize: 14,
      color: Colors.grey,
      fontFamily: "PinyonScript",
    );
  }

  static TextStyle taskTextStyle() {
    return TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontFamily: "PinyonScript",
    );
  }

  static TextStyle appBarTextStyle() {
    return TextStyle(
      fontSize: 24,
      color: Colors.black,
      fontFamily: "PinyonScript",
    );
  }

  static String capitalizeWords(String text) {
    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;

          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  // Görev adı
  static TextStyle taskDetailTitleStyle() {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: darkText,
    );
  }

  // Görev Bilgileri başlığı
  static TextStyle sectionTitleStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: darkText,
    );
  }

  // Tamamlandı / Yapılacak
  static TextStyle taskStatusStyle(bool isCompleted) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: isCompleted ? Colors.green : Colors.orange,
    );
  }

  // Oluşturulma Tarihi / Saat
  static TextStyle infoTitleStyle() {
    return const TextStyle(fontSize: 12, color: Colors.black54);
  }

  // Tarih ve saat değerleri
  static TextStyle infoTextStyle() {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: darkText,
    );
  }
}
