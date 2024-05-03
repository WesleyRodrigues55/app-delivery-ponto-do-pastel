import 'package:flutter/material.dart';
 
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
 
  List<Widget> listaListTiles = [];
  String valueTextFieldName = '';
  String valueTextFieldEmail = '';
  bool changedCheckbox = true;
  bool changedSwitchButton = true;
  String groupValueRadio = '';
 
  void validaCampos() {
    if (formKey.currentState!.validate()) {
      snack('Formulário enviado');
    } else {
      snack('OS campos precisam ser preenchidos');
    }
  }
 
 
  void showNameForm(value) {
    setState(() {
      valueTextFieldName = value;
    });
  }
 
  void showEmailForm(value) {
    setState(() {
      valueTextFieldEmail = value;
    });
  }
 
  void snack(String message) {
    ScaffoldMessenger
      .of(context)
      .showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
        )
      );
  }
 
  void addInLista() {
    setState(() {
      listaListTiles.add(generatorListTileConfig());
      listaListTiles.add(const Divider());
      listaListTiles.add(generatorListTileContact());
      listaListTiles.add(const Divider());
    });
  }
 
  ListTile generatorListTileContact() {
    return ListTile(
      leading: CircleAvatar(),
      title: Text("My title"),
      subtitle: Text("My Subtitle"),
      trailing: Icon(Icons.call),
      tileColor: Colors.orange,
      onTap: () => snack('Ligando para o contato X!'),
    );
  }
 
  ListTile generatorListTileConfig() {
    return ListTile(
      leading: const CircleAvatar(),
      title: const Text("Title tile"),
      tileColor: const Color.fromARGB(255, 212, 212, 212),
      subtitle: const Text('Description of tile...'),
      trailing: const Icon(Icons.add),
      onTap: () => snack('Clicou no config')
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.NmWmwsxXqai-rXinfwArmAHaFj?rs=1&pid=ImgDetMain'),
                ),
                const SizedBox(height: 40,),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    hintText: 'Digite seu e-mail cadastrado...'
                  ),
                  validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Digite um email válido!';
                      }
                      return null;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    hintText: 'Digite sua senha...'
                  ),
                  validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Digite um email válido!';
                      }
                      return null;
                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    validaCampos();
                  },
                  child: Text('Salvar')
                )
              ],
            ),
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addInLista,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}