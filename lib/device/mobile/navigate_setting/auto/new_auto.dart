import 'package:flutter/material.dart';
class NewAuto extends StatefulWidget {
  const NewAuto({super.key});

  @override
  State<NewAuto> createState() => _NewAutoState();
}

class _NewAutoState extends State<NewAuto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Auto",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
         padding:EdgeInsets.only(left: 50,right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: TextFormField(
                         decoration: const InputDecoration(
                             icon: Icon(Icons.person),
                          hintText: 'Do you want to edit commune?',
                          labelText: 'Commune',
                            ),
                     onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                                    },
                                  )
                  ),
             Container(
              child: TextFormField(
                         decoration: const InputDecoration(
                             icon: Icon(Icons.person),
                          hintText: 'Do you want to edit District?',
                          labelText: 'District',
                            ),
                     onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                                    },
                                  )
            ),
             Container(
              
              child: TextFormField(
                         decoration: const InputDecoration(
                             icon: Icon(Icons.person),
                          hintText: 'Do you want to edit province?',
                          labelText: 'Province',
                            ),
                     onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                                    },
                                  )
            ),
            SizedBox(height: 10,),
            Divider(height: 5,color: Colors.black,thickness: 2,),
            Container(
              
              child: TextFormField(
                         decoration: const InputDecoration(
                             icon: Icon(Icons.person),
                          hintText: 'Do you want to edit province?',
                          labelText: 'Main Road Min Value',
                            ),
                     onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                                    },
                                  )
            ),
            Container(
              
              child: TextFormField(
                         decoration: const InputDecoration(
                             icon: Icon(Icons.person),
                          hintText: 'Do you want to edit province?',
                          labelText: 'Sub Road Min Value',
                            ),
                     onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                                    },
                                  )
            ),
            Container(
              
              child: TextFormField(
                         decoration: const InputDecoration(
                             icon: Icon(Icons.person),
                          hintText: 'Do you want to edit province?',
                          labelText: 'Main Road Max Value',
                            ),
                     onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                                    },
                                  )
            ),
             Container(
              
              child: TextFormField(
                         decoration: const InputDecoration(
                             icon: Icon(Icons.person),
                          hintText: 'Do you want to edit province?',
                          labelText: 'Sub Road Max Value',
                            ),
                     onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                                    },
                                  )
            ),
          ],
        ),
      ),
    );
  }
}