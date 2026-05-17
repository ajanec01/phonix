import 'dart:convert';
import 'package:flutter/services.dart';
import 'curriculum_service.dart';

class LocalCurriculumService implements CurriculumService {
  @override
  Future<List<Map<String, dynamic>>> fetchPhases() async {
    final raw = await rootBundle.loadString('assets/curriculum/phases.json');
    final list = jsonDecode(raw) as List<dynamic>;
    return list.cast<Map<String, dynamic>>();
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAspects(int phaseNumber) async {
    final raw = await rootBundle
        .loadString('assets/curriculum/phase${phaseNumber}_aspects.json');
    final list = jsonDecode(raw) as List<dynamic>;
    return list.cast<Map<String, dynamic>>();
  }
}
