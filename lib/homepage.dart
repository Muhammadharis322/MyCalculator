
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:mycalculator/buttons.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var UserQuestion="";
  var UserAnswer="";


  final List<String> btns=
  [
    "C" , "Del" , "%" , "/",
    "9" , "8" , "7" , "x",
    "6" , "5" , "4" , "-",
    "3" , "2" , "1" , "+",
    "0" , "." , "Ans" , "=",
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal[50],
    
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 50,),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(UserQuestion,style: TextStyle(fontSize: 30),)
                      ),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(UserAnswer,style: TextStyle(fontSize: 50),)
                      ),
                  ],
                ),
    
              ),
            ),
            Expanded(
              flex: 2, //2 times greater than top portion
              child: Container(
                child: GridView.builder(
                 itemCount: btns.length,
                 gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                 itemBuilder: (BuildContext context, int index){
                 
                 //Clear Button
                 if (index==0)
                 {
                    return MyButton(
                    ButtonTapped: (){
                      setState(() {
                        UserQuestion='';
                      });
                    },
                    buttonText:btns[index] ,
                    color:  Colors.lightGreen[700],
                    textColor: Colors.white 
                  );
                 }
                 //Delete Button
                 else if(index==1)
                 {
                    return MyButton(
                    ButtonTapped: (){
                      setState(() {
                        UserQuestion = UserQuestion.substring(0,UserQuestion.length-1);
                      });
                    },
                    buttonText:btns[index] ,
                    color:  Colors.red[700],
                    textColor: Colors.white
                    );
                 }
                 //Equals Button
                 else if(index==btns.length-1)
                 {
                    return MyButton(
                    ButtonTapped: (){
                      setState(() {
                        EqualPressed();
                      });
                    },
                    buttonText:btns[index] ,
                    color:  Colors.teal[700],
                    textColor: Colors.white
                    );
                 }
                 else
                 {
                   return MyButton(
                    ButtonTapped: (){
                      setState(() {
                        UserQuestion += btns[index];   
                      });
                      
                    },
                    buttonText:btns[index] ,
                    color: IsOperator(btns[index]) ? Colors.teal[700] : Colors.teal[200],
                    textColor: IsOperator(btns[index])? Colors.white : Colors.black 
                  );
                 }
                 }),
    
              ),
            ),
          ],
        ),
      ),
    );
  }

  //method
  bool IsOperator(String x)
  {
    if(x == "%" || x == "/" || x == "x" || x == "+" || x == "-" || x == "=" )
    {
      return true;
    }
    return false;
  }


  void EqualPressed() {
    String FinalQuestion=UserQuestion;
    
    FinalQuestion=FinalQuestion.replaceAll("x", "*");
    FinalQuestion=FinalQuestion.replaceAll("Ans", UserAnswer);

    Parser p = Parser();
    Expression exp = p.parse(FinalQuestion);

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    UserAnswer=eval.toString();
  }
}