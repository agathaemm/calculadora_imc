import 'package:flutter/material.dart';

// Função principal do meu projeto
void main() {

  // Roda o meu app
  runApp(MaterialApp(

    // Chama a minha view
    home: Home(), 
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Controladores do input
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  // chave global que sera utilizada para realizar a validação do form
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Seta mensagem da tela
  String _infoText = "Informe seus dados";

  /**
   * Reinicia o formulario
   */
  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey  = GlobalKey<FormState>();
    });
  }

  /**
   * Faz o calculo do imc
   */
  void _calcularImc() {
    setState(() {

      // Pega os dados do formulario
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      // Calcula o IMC
      double imc = weight / (height * height);

      // Verifica o tipo do peso da pessoa
      if(imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }  
    });
  }

  @override
  Widget build(BuildContext context) {

    // Facilita para colocar widgets do material design
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ), 
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // SingleChildScrollView permite o scroll da pagina
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form( // Meu formulario
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Deixa o contrudo ocupando toda a largura
            children: <Widget>[
              Icon(Icons.person_outline, size: 120, color: Colors.green), // Icone
              TextFormField( // Input
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(
                    color: Colors.green
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25
                ),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty) {
                    return "Insira seu Peso";
                  }
                },
              ),
              TextFormField( // Input
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(
                    color: Colors.green
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25
                ),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty) {
                    return "Insira sua Altura";
                  }
                },
              ),
              Padding( // Adiciona um padding ao botão
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container( // Necessario para setar uma altura ao botão
                  height: 50,
                  child: RaisedButton( // Botão do formulario
                    onPressed: (){
                      // Faz a validação do formulario
                      if(_formKey.currentState.validate()) {
                        // Se formulario valido calcula o imc
                        _calcularImc();
                      } 
                    },
                    child: Text(
                      "Calcular", 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25
                      )),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}