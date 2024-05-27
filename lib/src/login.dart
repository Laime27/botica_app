import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart';
import 'registro.dart'; 
import 'principal.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

bool _obscureText = true;

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


 final TextEditingController _emailController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();


  void login(String email, String password) async{
    Response response = await post(Uri.parse('https://apibotica-production.up.railway.app/api/login'), 
    body: {
      'email': email,
      'password': password,
    });
    if(response.statusCode == 200){
     
    Navigator.pushAndRemoveUntil(
        context,MaterialPageRoute(builder: (context) => MyApp()), 
       (Route<dynamic> route) => false,
      );
      
    }else{
       showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error de inicio de sesión'),
            content: Text('Correo o contraseña incorrectos'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          
          child: Column(
         
            children: [
               SizedBox(height: 50),
              Image.asset(
                'assets/logo.jpg',
                width: 180,
                height: 150,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                   
                       children: [ 
                  
                      Text(
                        "Bienvenido",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 50),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Correo Electrónico",
                         prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                           if (value!.isEmpty) {
                          return 'Por favor ingresa tu correo electrónico';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Por favor ingresa un correo electrónico válido';
                        }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: "******",
                          prefixIcon: Icon(Icons.lock),
                           suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {

                  if (_formKey.currentState!.validate()) {
                    login(_emailController.text.toString(), _passwordController.text.toString());
                  }
                },
                child: Text("Iniciar Sesión"),
              ),
             
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()), 
                    );
              },
                child: Text("Registrarse"),
              ),
            ],
          ),
        ),
      );
    
  }
}
