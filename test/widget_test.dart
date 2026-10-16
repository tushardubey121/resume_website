import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/main.dart';

Future<void> _pumpAt(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const ResumeWebsiteApp());
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  for (final size in const [Size(1440, 900), Size(820, 1180), Size(390, 844)]) {
    testWidgets('renders without layout errors at ${size.width.toInt()}px', (
      tester,
    ) async {
      await _pumpAt(tester, size);
      expect(tester.takeException(), isNull);
      expect(find.textContaining('Tushar Dubey'), findsWidgets);
      expect(find.text('Spice Money Adhikari'), findsOneWidget);
      expect(find.text('Travel Union'), findsOneWidget);
      for (final name in ['Haulink', 'Journies', 'Argo Texas Group']) {
        expect(find.text(name), findsOneWidget);
      }
    });
  }

  testWidgets('shows 8+ years of experience', (tester) async {
    await _pumpAt(tester, const Size(1440, 900));
    expect(find.text('8+ years'), findsOneWidget);
  });

  test('Travel Union is attributed to Spice Money', () {
    final travelUnion = ResumeData.featuredProjects.firstWhere(
      (p) => p.id == 'travel-union',
    );
    expect(travelUnion.builtAt, 'Spice Money');
    final techahead = ResumeData.experience.firstWhere(
      (e) => e.company.startsWith('Techahead'),
    );
    expect(techahead.highlights.join(' '), isNot(contains('Travel Union')));
  });

  test('no phone number is published', () {
    final all = [
      ...ResumeData.experience.expand((e) => e.highlights),
      ResumeData.profile.email,
    ].join(' ');
    expect(all, isNot(contains('8005468041')));
  });
}
