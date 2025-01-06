enum Status {
  INITIAL,
  LOADING,
  SUCCESS,
  ERROR,
}

abstract class StateMessage {
  final String message;

  StateMessage(this.message);
}

class SuccessMessage extends StateMessage {
  SuccessMessage(super.message);
}

class ErrorMessage extends StateMessage {
  ErrorMessage(super.message);
}

class InfoMessage extends StateMessage {
  InfoMessage(super.message);
}
