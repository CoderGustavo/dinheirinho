import 'package:flutter/material.dart';
import 'package:dinheirinho/mineirinho.dart';  // Importa o arquivo second_screen.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela Modernista',
      debugShowCheckedModeBanner: false, // Remover a faixa de debug
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[800], // Definindo a cor de fundo como um cinza mais escuro
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20), // Adicionando margem abaixo da imagem
                child: Image.network(
                  'https://www.clashroyaledicas.com/wp-content/uploads/2016/05/miner-clash-royale-cart-ilustration-wiki-mineiro.png', // URL da sua imagem
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain, // Ajuste da imagem dentro do Container
                ),
              ),
              Text(
                'Iniciar Mineirinho',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold, // Definindo o texto como negrito
                  color: Colors.white, // Definindo a cor do texto como branco
                ),
              ),
              SizedBox(height: 32), // Espaço entre o texto e o botão
              ElevatedButton(
                onPressed: () {
                  // Navegação para a segunda tela
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Mineirinho()),
                  );
                },
                child: Text(
                  'Bora começar',
                  style: TextStyle(color: Colors.white, fontSize: 16), // Definindo a cor do texto do botão como branco
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Definindo a cor do botão como vermelho
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
