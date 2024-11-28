

// import 'package:eliane_noivas_mobile/dominio/locacao.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarioControler extends GetxController{
//   // var now = DateTime.now();
//   // var firstDay = DateTime(now.year, now.month - 3, now.day);
//   // var lastDay = DateTime(now.year, now.month + 3, now.day);

//   late DateTime now;
//   late DateTime firstDay;
//   late DateTime lastDay;
//   List<String> agenda = [];

//   CalendarFormat format = CalendarFormat.month;
//   String locale = 'pt-BR';

//   @override
//   void onInit() async{
//     now = DateTime.now();
//     firstDay = DateTime(now.year, now.month - 3, now.day);
//     lastDay = DateTime(now.year, now.month + 3, now.day);
//     getProgramacaoDoDia(now);
//     super.onInit();
//   } 
  
//   Future getProgramacaoDoDia(data) async{
//     now = data;
//     getAgenda(data);
//     update(['calendario', 'agenda']);

//   } 

//   void getAgenda(DateTime data){
//     //agenda = Locacao().buscarPorData(data);
//     agenda.clear();

//     if (data.day == 28){
//       agenda = [
//         '08:00 - Entregar vestido da Noiva: Maria',
//         '09:00 - Atender a Noiva: Joana',
//         '10:00 - Entregar o vestido da debutante:  Ana',
//       ];
//     }else if (data.day == 29){
//       agenda = [
//         '08:00 - Entregar vestido da Noiva: Maria',
//         '09:00 - Atender a Noiva: Joana',
//         '10:00 - Entregar o vestido da debutante:  Ana',
//         '11:00 - Entregar o vestido da Noiva: Maria',
//         '12:00 - Atender a Noiva: Joana',
//       ];
//     }
//   }

// }

