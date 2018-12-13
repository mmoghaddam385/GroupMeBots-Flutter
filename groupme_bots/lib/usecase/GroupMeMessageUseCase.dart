
import 'package:groupme_bots/repo/GroupMeMessageRepository.dart';
import 'package:groupme_bots/cache/GroupMeMessageCache.dart'; // Yea I'm skipping a layer, sue me

// Singleton instance
final GroupMeMessageUseCase groupMeMessageUseCase = new GroupMeMessageUseCase._privateCtor();

class GroupMeMessageUseCase {

  GroupMeMessageUseCase._privateCtor();

  String get botId => groupMeMessageCache.botId;
  set botId(String val) => groupMeMessageCache.botId = val;

  Future<int> postMessage(String message) async {
    return groupMeMessageRepository.postGroupMeMessage(message);
  }

}