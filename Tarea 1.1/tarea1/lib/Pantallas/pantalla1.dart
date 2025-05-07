import 'package:flutter/material.dart';

class Pantalla1 extends StatefulWidget {
  
  @override
  CalculadoraSueldo createState() {
    print('1. Ej 16. - createState');
    return CalculadoraSueldo();
  }
  
}

class CalculadoraSueldo extends State<Pantalla1>{

  // Declarar y mapear objetos

  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  String resultado = '';

  // Inicializar variables, cargar datos, iniciar animaciones
  @override
  void initState() {
    super.initState();
    print('2. Ej 16. initState()');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('3. Ej 16. didChangeDependencies()');
  }

  @override
  void didUpdateWidget(covariant Pantalla1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('4. Ej 16. didUpdateWidget()');
  } // Comparar y reaccionar a cambios

  //Detección de salida temporal

  @override
  void deactivate() {
    super.deactivate();
    print('5. Ej 16. deactivate()');
  }

  @override
  void dispose() {
    print('6. Ej 16. dispose()');
    num1Controller.dispose();
    num2Controller.dispose();
    super.dispose();
  }

  //logica

  void calcular_sueldo(){
  
    String respuesta = '';
    const double sueldo_base = 35000;
    const double coeficiente_antiguedad = 100;
    double? edad = double.tryParse(num1Controller.text);
    double? antiguedad = double.tryParse(num2Controller.text);
    
    bool data_valida = true;
    double resultado = 0;
    
    if(edad == null){
      respuesta += 'Formato incorrecto en la entrada de la edad.\n';
      data_valida = false;
    }
    if(antiguedad == null){
      respuesta += '\nFormato incorrecto en la entrada de la antiguedad.';
      data_valida = false;
    }

    if(!data_valida){
      return;
    }else{
      if(edad !< 18 || edad !> 120){
        respuesta += 'El empleado debe ser mayor de edad y coherente.\n';
      }
      if(antiguedad !<= 0 || antiguedad !>= 80){
        respuesta += 'La antiguedad no puede ser menor a 1 año.';
      }
      if(respuesta == ''){
        double sumatoria = 0;
        for(int i = 1; i <= antiguedad; i++){
          sumatoria += i;
        }
        resultado += sueldo_base + edad + coeficiente_antiguedad * sumatoria;
        respuesta = 'El sueldo total del empleado es de $resultado';
      }
    }

    setState(() {
      this.resultado = respuesta;
    });  
  
  }

  // Diseño
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo de Sueldo"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Ingrese la edad del empleado."),
            ),

            SizedBox(height: 10),

            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Ingrese la antiguedad del empleado."),
            ),

            SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(onPressed: () => calcular_sueldo(), child: Text("Calcular"))
              ],
            ),

            SizedBox(height: 20),

            Text(resultado, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

}