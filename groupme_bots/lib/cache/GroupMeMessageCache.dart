
final GroupMeMessageCache groupMeMessageCache = GroupMeMessageCache._privateCtor();

class GroupMeMessageCache {

  static final String _BOT_ID_PREFS_KEY = "botId";

  GroupMeMessageCache._privateCtor();

  String _botId;
  String get botId => _botId;
  set botId(String id) {
    _botId = id;
  }

  // Get the initial bot ID from shared prefs 
  void initBotId() {
    _botId = "placeholder";
  }

}