sealed class GlobalResponse {
  const GlobalResponse();
}

final class GlobalResponseSuccess extends GlobalResponse {
  final String message;

  GlobalResponseSuccess(this.message);
}

final class GlobalResponseFailure extends GlobalResponse {
  final String message;

  GlobalResponseFailure(this.message);
}
