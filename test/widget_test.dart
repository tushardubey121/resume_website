import 'package:flutter_test/flutter_test.dart';
import 'package:resume_website/main.dart';

void main() {
  testWidgets('Portfolio renders name', (tester) async {
    await tester.pumpWidget(const ResumeWebsiteApp());
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.textContaining('Tushar Dubey'), findsWidgets);
  });
}
