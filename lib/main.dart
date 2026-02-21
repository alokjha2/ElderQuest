import 'bootstrap.dart';
import 'presentation/app/elder_quest_app.dart';

Future<void> main() async {
  await bootstrap(() => const ElderQuestApp());
}
