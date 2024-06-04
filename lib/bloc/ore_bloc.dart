import 'package:dinheirinho/models/Ore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class OreEvent extends Equatable {
  const OreEvent();

  @override
  List<Object> get props => [];
}

class UpgradeOre extends OreEvent {
  final double currentMoney;

  const UpgradeOre(this.currentMoney);

  @override
  List<Object> get props => [currentMoney];
}

abstract class OreState extends Equatable {
  const OreState();

  @override
  List<Object> get props => [];
}

class OreInitial extends OreState {}

class OreUpdated extends OreState {
  final OreModel oreModel;

  const OreUpdated(this.oreModel);

  @override
  List<Object> get props => [oreModel];
}

class OreBloc extends Bloc<OreEvent, OreState> {
  final OreModel oreModel;

  OreBloc(this.oreModel) : super(OreInitial()) {
    on<UpgradeOre>((event, emit) {
        oreModel.upgradeOre(event.currentMoney);
        emit(OreUpdated(oreModel));
    });
    on<UpgradeOre>((event, emit) {
        oreModel.unlockOre(event.currentMoney);
        emit(OreUpdated(oreModel));
    });
  }
}
