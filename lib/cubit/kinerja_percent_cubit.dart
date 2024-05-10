import 'package:flutter_bloc/flutter_bloc.dart';

class KinerjaPercentCubit extends Cubit<double> {
  KinerjaPercentCubit() : super(0.0);

  void setKinerjaPercent({required int kinerja}) {
    double value = kinerja / 100;

    emit(value);
  }
}
