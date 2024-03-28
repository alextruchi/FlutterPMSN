class SessionUsu {
  static final SessionUsu _instance = SessionUsu._internal();

  factory SessionUsu() {
    return _instance;
  }

  SessionUsu._internal();

  String? idSession;

  void setSessionId(String id) {
    idSession = id;
  }

  String? getSessionId() {
    return idSession;
  }
}