
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

 bool _obscureText = true;

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String? _emailError;

  void registrar( String nombre, String correo, String clave) async{
    Response response = await post(Uri.parse('https://apibotica-production.up.railway.app/api/registrar'),
      body:{
        'name': nombre,
        'email': correo,
        'password': clave,
      });
    if(response.statusCode == 200){
   
      Navigator.pushReplacement(
        context,MaterialPageRoute(builder: (context) => Login()),
      );

    }else {
       setState(() {
          _emailError = 'El correo electrónico ya existe';
        });
      
      // final jsonResponse = json.decode(response.body);
      // final errors = jsonResponse['mensaje'] as Map<String, dynamic>;
      // if (errors.containsKey('email')) {
      //   setState(() {
      //     _emailError = errors['email'][0];
      //   });
      // }
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
         body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        "Registro",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "Nombre",
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor ingresa un nombre';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                           controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Correo Electrónico",
                          errorText: _emailError,
                           prefixIcon: Icon(Icons.email),
                          ),
                         
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor ingresa un correo electrónico';
                          }else if (!EmailValidator.validate(value)) {
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
                          hintText: "Contraseña",
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
                              return 'Por favor ingresa una contraseña';
                            }else if (value.length < 8) {
                              return 'La contraseña debe tener al menos 8 caracteres';
                            }
                              
                          return null;
                        },
                          
                      ),
                    ],
                  ),
                  
                ),
              ),

              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                   registrar(_nameController.text.toString(), _emailController.text.toString(), _passwordController.text.toString());
                  }
                },
                child: Text("Registrarse"),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
