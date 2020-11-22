import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';

class ItemBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyUserProfile profile = Provider.of<MyUserProfile>(context);

    return  Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(

                width: MediaQuery.of(context).size.width,
                height: 80,
                color: Color(0xff162841),
                child: Row(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.only(right: 10,bottom: 5),
                        child: Column(

                          children: <Widget>[
                            Spacer(flex: 2,),
                            Image.asset('assets/gems.png',width: 35,),
                            Spacer(flex: 1,),
                            Text(profile.gems.toString(),style: TextStyle(color: Colors.white),)

                          ],
                        ),
                      width: 80,
                decoration: BoxDecoration(
                    color: Color(0xff0D1829),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40),

              ),
                    )
                    ),

                    Spacer(),


                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.only(left: 10,bottom: 5),
                      child: Column(

                        children: <Widget>[
                          Spacer(flex: 2,),
                          Image.asset('assets/gold.png',width: 35,),
                          Spacer(flex: 1,),
                          Text(profile.gold.toString(),style: TextStyle(color: Colors.white),)

                        ],
                      ),
                        width: 80,
                        decoration: BoxDecoration(
                          color: Color(0xff0D1829),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40),

                          ),
                        )
                    ),
                  ],
                ),


              ),

              Positioned(
                child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(profile.img)
                ),
              ),
            ],
          );

  }
}
