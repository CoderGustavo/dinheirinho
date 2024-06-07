import 'package:dinheirinho/bloc/money_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/appCard.dart';
import 'models/Ore.dart';

void main() {
  runApp(const Mineirinho());
}

class Mineirinho extends StatelessWidget {
  const Mineirinho({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mineirinho',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => MoneyBloc(),
        child: MyHomePage(title: 'Mineirinho'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  final List<OreModel> ores = [
    OreModel(
        image: 'https://img.freepik.com/vetores-premium/pedregulho-de-carvao-jogo-de-desenho-animado-pedra-elemento-de-rocha_53562-18283.jpg',
        name: "Carvão",
        progress: 0.0,
        value: 1,
        upgradePrice: 60.00,
        upgradeLevel: 0,
        unlockPrice: 0,
        isActive: true,
        minerPrice: 150
    ),
    OreModel(
        image: 'https://m.media-amazon.com/images/I/61n9ZZHAdrL._AC_UF894,1000_QL80_.jpg',
        name: "Cobre",
        progress: 0.0,
        value: 10.00,
        upgradePrice: 700.00,
        unlockPrice: 500.00,
        upgradeLevel: 0,
        minerPrice: 2000.00
    ),
    OreModel(
        image: 'https://e7.pngegg.com/pngimages/183/459/png-clipart-computer-icons-bronze-icon-design-steel-miscellaneous-medal.png',
        name: "Bronze",
        progress: 0.0,
        value: 100,
        upgradePrice: 2000.00,
        unlockPrice: 8000.00,
        upgradeLevel: 0,
        minerPrice: 15000
    ),
    OreModel(
        image: 'https://w7.pngwing.com/pngs/218/541/png-transparent-cartoon-iron-cartoon-character-electronics-mode-of-transport.png',
        name: "Ferro",
        progress: 0.0,
        value: 1000,
        upgradePrice: 10000.00,
        unlockPrice: 25000,
        upgradeLevel: 0,
        minerPrice: 30000
    ),
    OreModel(
        image: 'https://img.freepik.com/vetores-premium/barra-de-ouro-ilustracao-em-desenho-vetorial-de-barra-de-metal_574806-4209.jpg',
        name: "Ouro",
        progress: 0.0,
        value: 10000,
        upgradePrice: 50000.00,
        unlockPrice: 1000000.00,
        upgradeLevel: 0,
        minerPrice: 1500000
    ),
    OreModel(
        image: 'https://gartic.com.br/imgs/mural/gr/grazieleb/diamante.png',
        name: "Diamante",
        progress: 0.0,
        value: 100000,
        upgradePrice: 1000000000.00,
        unlockPrice: 1500000000.00,
        upgradeLevel: 0,
        minerPrice: 1500000000.00
    ),
  ];

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 122, 0, 0),
        title: BlocBuilder<MoneyBloc, MoneyState>(
          builder: (context, state) {
            double money = 0;
            if (state is MoneyUpdated) {
              money = state.money;
            }
            return Text(
              'Dinheiro: ${formatCurrency(money)}',
              style: const TextStyle(color: Color.fromRGBO(207, 207, 207, 1)),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<MoneyBloc, MoneyState>(
            builder: (context, state) {
              double money = 0;
              if (state is MoneyUpdated) {
                money = state.money;
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ores.map((ore) {
                  return GestureDetector(
                    onTap: () => ore.isActive ? context.read<MoneyBloc>().add(UpdateMoney(ore.value)) : "",
                    child: AppCard(
                      oreModel: ore,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}