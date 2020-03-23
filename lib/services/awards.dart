
import 'package:awesome_dialog/awesome_dialog.dart';
import '../services/services.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AwardsProvider{
  AwardsProvider({this.subjectName,this.topicID});
  Report report = Provider.of<Report>(Global.scaffoldKey.currentContext);
  Awards award;
  final String subjectName;
  final String topicID;
  List<Quiz> quizzes;


  Future<void> getQuzzes() async{

    quizzes =  await Global.quizRef.getMyData('subject',topicID);


  }

  shoWDialog(){


    print(report.awards);
    if(report.awards.length == 0) {
      award = Awards(name: 'FirstQuiz', img: '');

      print('doneeeeee');

      Global.reportRef.upsert(
        ({
          'awards': FieldValue.arrayUnion([{

            'img': award.img,
            'name': award.name
          }
          ])
        }),
      );


      return AwesomeDialog(context: Global.scaffoldKey.currentContext,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          tittle: 'Congratz You Get the ${award.name} award!',
          desc: '',
          btnOkOnPress: () {}).show();

    } else if(subjectName != null && topicID != null){

      if(report.subjects[subjectName][topicID].length == report.total){

        award = Awards(name: '$subjectName Hero',img: '');

        Global.reportRef.upsert(
          ({
            'awards': FieldValue.arrayUnion([{

              'img': award.img,
              'name': award.name
            }])

          }),
        );


        return AwesomeDialog(context: Global.scaffoldKey.currentContext,
            dialogType: DialogType.SUCCES,
            animType: AnimType.BOTTOMSLIDE,
            tittle: 'Congratz You Get the ${award.name} award!',
            desc: '',
            btnOkOnPress: () {}).show();

      }
    }

  }




}