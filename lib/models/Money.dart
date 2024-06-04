class MoneyModel {
  double money;

  MoneyModel({
    required this.money,
  });

  void setMoney(double money) {
    this.money = money;
  }

  void addMoney(double addMoney) {
    money += addMoney;
  }

  void spentMoney(double spentMoney) {
    money -= spentMoney;
  }

  double getMoney() {
    return money;
  }
}
