import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                  child:  GFButton(
                    color: Colors.green,
                     onPressed: (){},
                     text: "Edit",
                     shape: GFButtonShape.pills,
                      icon: Icon(Icons.edit,color: Colors.white,),
                      ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                  child:  GFButton(
                     onPressed: (){},
                     text: "Save",
                     shape: GFButtonShape.pills,
                      icon: Icon(Icons.save_alt,color: Colors.white,),
                      ),
                  ),
                ],
              ),
             ),
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
            Divider(height: 5,color: Colors.blue,thickness: 2,),
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