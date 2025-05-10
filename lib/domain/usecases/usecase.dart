import 'package:bloc_clean_arch/core/core.dart';
import 'package:fpdart/fpdart.dart';

/// Defines a usecase call method
///
/// S denotes the type returned from a success call
/// P denotes a model containing the parameters required to make a call
abstract interface class Usecase<S, P> {
  Future<Either<Failure, S>> call(P p);
}
