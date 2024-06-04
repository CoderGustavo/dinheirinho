import 'dart:ffi';

import 'package:dinheirinho/bloc/money_bloc.dart';
import 'package:dinheirinho/models/Money.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OreModel {
  String image;
  String name;
  double progress;
  double value;
  double upgradePrice;
  int upgradeLevel;
  double unlockPrice;
  bool manager;
  bool isActive;
  bool haveMiner = false;
  double minerPrice;
  Timer? _timer;

  OreModel({
    required this.image,
    required this.name,
    required this.progress,
    required this.value,
    required this.upgradePrice,
    required this.upgradeLevel,
    required this.unlockPrice,
    required this.minerPrice,
    this.manager = false,
    this.isActive = false,
  });

  String get getImage => image;
  set setImage(String newImage) => image = newImage;

  String get getName => name;
  set setName(String newName) => name = newName;

  double get getProgress => progress;
  set setProgress(double newProgress) => progress = newProgress;

  double get getValue => value;
  set setValue(double newValue) => value = newValue;

  double get getUpgradePrice => upgradePrice;
  set setUpgradePrice(double newUpgradePrice) => upgradePrice = newUpgradePrice;

  int get getUpgradeLevel => upgradeLevel;
  set setUpgradeLevel(int newLevel) => upgradeLevel = newLevel;

  double get getUnlockPrice => unlockPrice;
  set setUnlockPrice(double newUnlockPrice) => unlockPrice = newUnlockPrice;

  bool get isManager => manager;
  set setManager(bool isManager) => manager = isManager;

  double get getMinerPrice => minerPrice;
  set setMinerPrice(double newMinerPrice) => minerPrice = newMinerPrice;

  void upgradeOre(double money) {
    if (money >= this.upgradePrice) {
      upgradeLevel += 1;
      value *= 1.5;
      upgradePrice *= 1.5;
    }
  }

  void unlockOre(double money) {
    if (money >= this.unlockPrice) {
      isActive = true;
    }
  }

  void automateOre(BuildContext context, double money) {
    if (_timer == null && money >= this.minerPrice) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        context.read<MoneyBloc>().add(UpdateMoney(value));
      });
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}
