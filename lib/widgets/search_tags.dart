import 'package:flutter/material.dart';

class SearchItens extends StatefulWidget {
  const SearchItens({Key? key}) : super(key: key);

  @override
  State<SearchItens> createState() => _SearchItensState();
}

class _SearchItensState extends State<SearchItens> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        // color: Colors.blue,
                        image: DecorationImage(image: AssetImage('assets/natureza.png'),
                        fit: BoxFit.cover)
                      ),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Stack(
                          children: [
                            Text("Natureza",style: TextStyle(
                            // color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2.5
                              ..color = Colors.black,
                          ),),
                          Text("Natureza",style: TextStyle(
                            color: Colors.white,

                            fontWeight: FontWeight.w600,
                            fontSize: 24,))
                          ] 
                        ),
                      ),
                    )),
                    SizedBox(width: 10,),
                    Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        // color: Colors.blue,
                        image: DecorationImage(image: AssetImage('assets/festival.png'),
                        fit: BoxFit.cover)
                      ),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Stack(
                          children: [
                            Text("Festivais",style: TextStyle(
                            // color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2.5
                              ..color = Colors.black,
                          ),),
                          Text("Festivais",style: TextStyle(
                            color: Colors.white,

                            fontWeight: FontWeight.w600,
                            fontSize: 24,))
                          ] 
                        ),
                      ),
                    )),
                    
                ],
              ),
              SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        // color: Colors.blue,
                        image: DecorationImage(image: AssetImage('assets/lgbt.png'),
                        fit: BoxFit.cover)
                      ),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Stack(
                          children: [
                            Text("LGBTQIA+",style: TextStyle(
                            // color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2.5
                              ..color = Colors.black,
                          ),),
                          Text("LGBTQIA+",style: TextStyle(
                            color: Colors.white,

                            fontWeight: FontWeight.w600,
                            fontSize: 24,))
                          ] 
                        ),
                      ),
                    )),
                    SizedBox(width: 10,),
                    Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        // color: Colors.blue,
                        image: DecorationImage(image: AssetImage('assets/rock.png'),
                        fit: BoxFit.cover)
                      ),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Stack(
                          children: [
                            Text("Rock",style: TextStyle(
                            // color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2.5
                              ..color = Colors.black,
                          ),),
                          Text("Rock",style: TextStyle(
                            color: Colors.white,

                            fontWeight: FontWeight.w600,
                            fontSize: 24,))
                          ] 
                        ),
                      ),
                    )),
                    
                ],
              )
            ],
          ),
        ),
      );
  }
}