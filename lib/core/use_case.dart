abstract class UseCase<T, P> {
  Future<P> call(T? t);
}

abstract class UseCaseWithoutParams<P> {
  Future<P> call();
}
