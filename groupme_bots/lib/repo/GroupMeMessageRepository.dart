
import 'package:groupme_bots/cache/GroupMeMessageCache.dart';
import 'package:groupme_bots/error/Exceptions.dart';
import 'package:http/http.dart' as http;

final GroupMeMessageRepository groupMeMessageRepository = GroupMeMessageRepository._privateCtor();

class GroupMeMessageRepository {

  static const String _GROUP_ME_BOT_POST_URL = "https://api.groupme.com/v3/bots/post";

  GroupMeMessageRepository._privateCtor();

  Future<int> postGroupMeMessage(String message) async {
    if (groupMeMessageCache.botId == null || groupMeMessageCache.botId == "") {
      throw new IllegalStateException("Bot ID can't be null or empty!");
    }

    http.Response response = await http.post(
      _GROUP_ME_BOT_POST_URL,
      body: {
        "bot_id": groupMeMessageCache.botId,
        "text": message
      });

    if (response.statusCode != 202) {
      print(response.body);
      throw("Error posting your message :(");
    }

    return response.statusCode;
  }
}