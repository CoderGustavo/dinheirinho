import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Bloc
class MoneyBloc extends Bloc<MoneyEvent, MoneyState> {
  double _money = 0;

  MoneyBloc() : super(MoneyInitial()) {
    on<UpdateMoney>((event, emit) {
      _money += event.amount;
      emit(MoneyUpdated(_money));
    });
  }
}

// Event
abstract class MoneyEvent extends Equatable {
  const MoneyEvent();

  @override
  List<Object> get props => [];
}

class UpdateMoney extends MoneyEvent {
  final double amount;

  const UpdateMoney(this.amount);

  @override
  List<Object> get props => [amount];
}

// State
abstract class MoneyState extends Equatable {
  const MoneyState();

  @override
  List<Object> get props => [];
}

class MoneyInitial extends MoneyState {}

class MoneyUpdated extends MoneyState {
  final double money;

  const MoneyUpdated(this.money);

  @override
  List<Object> get props => [money];
}