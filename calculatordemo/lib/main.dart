import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(const Calculator());
}
class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorHome(),
    );
  }
}
class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {

  String equation = '0';
  String result = '0';
  String expression= '';

  buttonPressed(btnText){
    setState(() {
      if(btnText == 'AC'){

        equation ='0';
        result = '0';

      }else if(btnText == '⌫'){

        equation = equation.substring(0, equation.length-1);

        if(equation == ''){
          equation = '0';
        }

      }else if(btnText == '='){

        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');


        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';


        }
        catch(e){
          'Error';
        }

      }else{
        if(equation == '0' ){
          equation = btnText;

        }else
          equation= equation + btnText;


      }
    });
  }


  Widget calButtons(String btnText, Color txtColor, double btnWidth, Color btnColor){



    return InkWell(
      onTap: (){
        buttonPressed(btnText);

      },
      child: Container(
        alignment: Alignment.center,
        height: 80,
        width: btnWidth,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(50),
        ),

        child: Text(btnText, style: TextStyle(color: txtColor, fontSize: 30, fontWeight: FontWeight.w500),),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.elliptical(200, 100)
            )
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent[100],
        title: const Text('Calculator Demo', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.normal),),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          //display expression value
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            height: 90,
            width: double.infinity,
            color: Colors.black,
            child: SingleChildScrollView(child: Text(equation, style: TextStyle(color: Colors.deepOrangeAccent[100],fontSize: 38,),)),
          ),

          const SizedBox(height: 20,),
          //display result value
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            height: 90,
            width: double.infinity,
            color: Colors.black,
            child: SingleChildScrollView(child: Text(result, style: TextStyle(color: Colors.white,fontSize: 60,),)),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('AC', Colors.white, 80, Colors.white38!),
                    calButtons('⌫', Colors.black, 80, Colors.deepOrangeAccent[100]!),
                    calButtons('%', Colors.black, 80, Colors.deepOrangeAccent[100]!),
                    calButtons('÷', Colors.black, 80, Colors.deepOrangeAccent[100]!),


                  ],
                ),
                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('7', Colors.black, 80, Colors.white!),
                    calButtons('8', Colors.black, 80, Colors.white!),
                    calButtons('9', Colors.black, 80, Colors.white!),
                    calButtons('x', Colors.black, 80, Colors.deepOrangeAccent[100]!),


                  ],
                ),
                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('4', Colors.black, 80, Colors.white!),
                    calButtons('5', Colors.black, 80, Colors.white!),
                    calButtons('6', Colors.black, 80, Colors.white!),
                    calButtons('-', Colors.black, 80, Colors.deepOrangeAccent[100]!),


                  ],
                ),
                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('1', Colors.black, 80, Colors.white!),
                    calButtons('2', Colors.black, 80, Colors.white!),
                    calButtons('3', Colors.black, 80, Colors.white!),
                    calButtons('+', Colors.black, 80, Colors.deepOrangeAccent[100]!),


                  ],
                ),
                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('0', Colors.black, 170, Colors.white!),
                    calButtons('.', Colors.black, 80, Colors.white!),
                    calButtons('=', Colors.black, 80, Colors.deepOrangeAccent[100]!),


                  ],
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
