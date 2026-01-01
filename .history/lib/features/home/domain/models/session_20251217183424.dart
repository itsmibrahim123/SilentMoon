import 'package:flutter/material.dart';

class Session {
  final String id;
  final String title;
  final String? subtitle;
  final String? description;
  final String? duration;
  final String imageAsset;
  final Color color;
  bool isFavorited;
  bool isDownloaded;

  Session({
    required this.id,
    required this.title,
    this.subtitle,
    this.description,
    this.duration,
    required this.imageAsset,
    required this.color,
    this.isFavorited = false,
    this.isDownloaded = false,
  });
}
