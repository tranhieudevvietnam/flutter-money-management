class ResultBasic<T> {
  final String? message;
  final bool success;
  final T data;
  final String? statusCode;

  ResultBasic(
      {required this.success,
      required this.data,
      this.message,
      this.statusCode});
}
