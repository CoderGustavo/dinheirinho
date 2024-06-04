import 'package:dinheirinho/bloc/money_bloc.dart';
import 'package:dinheirinho/models/Ore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCard extends StatefulWidget {
  final OreModel oreModel;

  const AppCard({
    Key? key,
    required this.oreModel,
  }) : super(key: key);

  @override
  _AppCardState createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  String formatCurrency(double value) {
    if (value >= 1e12) {
      return 'R\$ ${(value / 1e12).toStringAsFixed(1)} Tri';
    } else if (value >= 1e9) {
      return 'R\$ ${(value / 1e9).toStringAsFixed(1)} Bi';
    } else if (value >= 1e6) {
      return 'R\$ ${(value / 1e6).toStringAsFixed(1)} Mi';
    } else if (value >= 1e3) {
      return 'R\$ ${(value / 1e3).toStringAsFixed(1)} Mil';
    } else {
      return 'R\$ ${value.toStringAsFixed(2)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.oreModel.isActive ? Colors.green[50] : Colors.red[50],
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage("${widget.oreModel.image}"),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: widget.oreModel.isActive
                      ? _buildActiveContent()
                      : _buildInactiveContent(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            widget.oreModel.isActive
                ? _buildActiveButtons(context)
                : _buildInactiveButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
         Text(
          "${widget.oreModel.name}",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[800]),
        ),
        Text(
          "${formatCurrency(widget.oreModel.value)}",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[800]),
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: widget.oreModel.progress,
          backgroundColor: Colors.green[100],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
        const SizedBox(height: 10),
        Text(
          "Nível de Upgrade: ${widget.oreModel.upgradeLevel}",
          style: TextStyle(fontSize: 16, color: Colors.green[700]),
        ),
      ],
    );
  }

  Widget _buildInactiveContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Mina Desativada",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red[800]),
        ),
        const SizedBox(height: 10),
        Text(
          "Desbloquear para gerar valor.",
          style: TextStyle(fontSize: 16, color: Colors.red[700]),
        ),
      ],
    );
  }

  Widget _buildActiveButtons(BuildContext context) {
    return Column(
      children: [
        _buildButtonWrapper(_buildUpgradeButton(context)),
        _buildButtonWrapper(_buildAutomateButton(context)),
      ],
    );
  }

  Widget _buildInactiveButtons(BuildContext context) {
    return Column(
      children: [
        _buildButtonWrapper(_buildUnlockButton(context)),
      ],
    );
  }

  Widget _buildButtonWrapper(Widget button) {
    return SizedBox(
      width: double.infinity,
      child: button,
    );
  }

  Widget _buildUpgradeButton(BuildContext context) {
    return BlocBuilder<MoneyBloc, MoneyState>(
      builder: (context, state) {
        double currentMoney = 0;
        if (state is MoneyUpdated) {
          currentMoney = state.money;
        }
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            if (currentMoney >= widget.oreModel.upgradePrice) {
              context
                  .read<MoneyBloc>()
                  .add(UpdateMoney(-widget.oreModel.upgradePrice));
              widget.oreModel.upgradeOre(currentMoney);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Dinheiro insuficiente para fazer upgrade."),
                ),
              );
            }
          },
          child: Text("Upgrade ${formatCurrency(widget.oreModel.upgradePrice)}"),
        );
      },
    );
  }

  Widget _buildUnlockButton(BuildContext context) {
    return BlocBuilder<MoneyBloc, MoneyState>(
      builder: (context, state) {
        double currentMoney = 0;
        if (state is MoneyUpdated) {
          currentMoney = state.money;
        }
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            if (currentMoney >= widget.oreModel.unlockPrice) {
              context
                  .read<MoneyBloc>()
                  .add(UpdateMoney(-widget.oreModel.unlockPrice));
              widget.oreModel.unlockOre(currentMoney);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Dinheiro insuficiente para desbloquear a mina."),
                ),
              );
            }
          },
          child: Text("Desbloquear Mina ${formatCurrency(widget.oreModel.unlockPrice)}"),
        );
      },
    );
  }

  Widget _buildAutomateButton(BuildContext context) {
    return BlocBuilder<MoneyBloc, MoneyState>(
      builder: (context, state) {
        double currentMoney = 0;
        bool haveMiner = widget.oreModel.haveMiner;

        if (state is MoneyUpdated) {
          currentMoney = state.money;
        }

        return haveMiner
            ? Center(
              child: 
              Text(
                "Minerador adquirido",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ))
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (currentMoney >= widget.oreModel.minerPrice) {
                    context
                        .read<MoneyBloc>()
                        .add(UpdateMoney(-widget.oreModel.minerPrice));
                    widget.oreModel.automateOre(context, currentMoney);
                    // Atualiza a UI para refletir a compra do minerador
                    setState(() {
                      widget.oreModel.haveMiner = true;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Dinheiro insuficiente para comprar o minerador"),
                      ),
                    );
                  }
                },
                child: Text("Comprar minerador ${formatCurrency(widget.oreModel.minerPrice)}"),
              );
      },
    );
  }
}
