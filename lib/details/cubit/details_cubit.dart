import 'package:flutter_bloc/flutter_bloc.dart';

class PlusCubit extends Cubit<int> {
  PlusCubit() : super(0);
  void plusOne() => emit(state + 1);
  void minusOne() => emit(state - 1);
}
