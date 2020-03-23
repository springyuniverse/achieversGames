import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mygame/services/services.dart';
import 'package:mygame/services/global_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';











class AddSubjectProvider with ChangeNotifier{


   MyUserProfile user;
   List<MySubject> userSubjects;
   int gold;
   int gems;




   Future<MyUserProfile> getUserData() async {

     user =  await Global.usersRef.getDocument();
     userSubjects = user.subjects;
     gems = user.gems;
     gold = user.gold;
     print(gems);
     return user;

   }





    updateUserReport() {




      if (this.user.gems >= 2) {
        user.gems -= 2;
        Global.usersRef.upsert(
          ({
            'gems': FieldValue.increment(-2),

          }),
        );
      }
notifyListeners();
  }




   addedSubjects(MySubject subject){



     for(MySubject sub in userSubjects){

       if(userSubjects.contains(sub)) {

         print('continued');
          continue;
          } else {
         print('tmaaaaaam');


       }
       }

         print('tmam keda');
         //update user score

         if (this.gems >= 2) {

           
           Global.userProfile.upsert(
             ({
               'gems': FieldValue.increment(-2),

               'subjects': FieldValue.arrayUnion([

                 {
                   'title': subject.title,
                   'img': subject.img,
                   'description': subject.description,


                 }
               ])
             }),
           );


//



       }




    notifyListeners();
  }

//
//
//
// int getGold(){
//      userGold();
//      return gold;
//  }
//
  int getGems(){
     notifyListeners();
    return user.gems;
  }
//
//
//  Future<void> userGold() async  {
//
//    MyUserProfile user = await  Global.usersRef.getDocument();
//    gold = user.gold;
//    notifyListeners();
//  }
//
//   Future<int> userGems() async {
//
//     MyUserProfile user = await  Global.usersRef.getDocument();
//     gems = user.gems;
//
//   }
}