import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'managers_state.dart';

class ManagersCubit extends Cubit<ManagersState> {
  ManagersCubit() : super(ManagersInitial());
}
