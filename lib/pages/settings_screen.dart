import 'package:flutter/material.dart';
import '../models/boid.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Positioned(
        left: 0,
        child:
        Material(
          type: MaterialType.transparency,
          child:
          SafeArea(child:AnimatedContainer(
            width: isOpen?300:50,
            height: isOpen?600:50,
            duration: const Duration(milliseconds: 150),
           margin: EdgeInsets.all(isOpen?0:6),
           curve: Curves.easeInOutCubicEmphasized,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(isOpen?0:50),
            ),

            child: !isOpen?IconButton(onPressed: (){
              setState(() {
                isOpen = !isOpen;
              });

            }, icon: const Icon(Icons.settings)):ListView(
              shrinkWrap: true,
              children:[
               Padding(padding: const EdgeInsets.all(8), child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Settings', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),
                    Container(

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child:IconButton(onPressed: (){
                      setState(() {
                        isOpen = !isOpen;
                      });
                    }, icon:  const Icon(
                        Icons.close,
                      size: 24,
                      weight: 1.0,
                      color: Colors.red,
                    )),)
                  ],
                ),
               ),

                Padding(padding: const EdgeInsets.all(8),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Alignment'),
                    Switch(
                      value: Boid.isLooking,
                      onChanged: (value){
                        setState(() {
                          Boid.setLooking(value);
                        });
                      },
                    ),
                  ],
                ),
                ),

                Padding(padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                      'Separation',
                    ),

                      Switch(
                          value: Boid.isAvoiding,
                          onChanged: (value){
                            setState(() {
                              Boid.setAvoiding(value);
                            });
                          },
                        ),
                    ],
                  ),
                ),

                Padding(padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Cohesion',
                      ),

                  Switch(
                        value: Boid.isCohering,
                        onChanged: (value){
                          setState(() {
                            Boid.setCohering(value);
                          });
                        },
                      )
                    ],
                  ),
                ),

                ListTile(
                  title: const Text('Perception')
                  ,
                  subtitle: Slider(
                      max: 100,
                      value: Boid.perception, onChanged: (value){
                    setState((){
                      Boid.perception=value;
                    });

                  }),
                ),


                ListTile(
                  title: const Text('separation strength')
                  ,
                  subtitle: Slider(value: Boid.separationWeight, onChanged: (value){
                    setState((){
                      Boid.separationWeight=value;
                    });

                  }),
                ),

                ListTile(
                  title: const Text('alignment strength'),
                  subtitle: Slider(value: Boid.alignmentWeight, onChanged: (value){
                    setState((){
                      Boid.setAlignmentWeight(value);
                    });

                  }),
                ),

                ListTile(
                  title: const Text('cohesion strength')
                  ,
                  subtitle: Slider(value: Boid.cohesionWeight, onChanged: (value){
                    setState((){
                      Boid.setCohesionWeight(value);
                    });

                  }),
                ),
              ],
            ),

        ),

    ),
    ),
    );
  }

}
