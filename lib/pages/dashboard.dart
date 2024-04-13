import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:haghocks/global_info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haghocks/pages/add_goal.dart';

class Dashboard extends StatefulWidget {
  GoogleSignInAccount account;
  AuthClient client;
  Dashboard(this.account, this.client);


  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  List<Event> upcoming_events = [];
  void updateCalendarInfo() async {
    upcoming_events = [];
    var calendar = CalendarApi(widget.client);
    var lis = await calendar.calendarList.list();
    for(var item in lis.items!){
      print(item.toJson());
    }
    final Events calEvents = await calendar.events.list(
      "fc161ef1dc0b063a465789a3e832e5d4a02a9e163f0dcfae07f5a4c265b5af9d@group.calendar.google.com"  
    );
    List<Event> events = calEvents.items!;
    for(Event event in events){
      String? description = event.toJson()["description"];
      if(description != null && description.contains("PP Approved")){
        upcoming_events.add(event);
        print(event.toJson()["summary"]);
      }
    }
    setState(() {});
  }
  void initState(){
    updateCalendarInfo();
    super.initState();
  }
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height, 
        width: width,
        color: Custom_Color.background,
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 55,
                        bottom: 10,
                        left: 20
                      ),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Custom_Color.main_blue, 
                        borderRadius: BorderRadius.circular(5), 
                      ),
                      padding: EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.5),
                        child: Image.network(
                          widget.account.photoUrl!
                        ),
                      ),
                    ), 
                    SizedBox(width: 10,),
                    Container(
                      margin: EdgeInsets.only(top: 42),
                      width : 300,
                      child : Text(
                          "",
                          maxLines : 1,
                          style: GoogleFonts.fredoka(
                            color: Custom_Color.main_blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 32, 
                          ),
                        )
                    )
                  ],
                ),
                Container(
                  width: width * 0.95,
                  height: height * 0.22,
                  margin: EdgeInsets.only(
                  
                    left: width * 0.0
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), 
                    color: Custom_Color.background_shade.withOpacity(0.7)
                  ),
                  padding: EdgeInsets.all(
                    10
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 7
                        ),
                        child: Text(
                          "Today :",
                          style: GoogleFonts.poppins(
                            color: Custom_Color.text_shade,
                            fontWeight: FontWeight.w800,
                            fontSize: 25,
                          ),
                        ),
                      ), 
                      SizedBox(height: 5,),
                      Expanded(
                        child: Container(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            children: [
                              ...upcoming_events.map((data){
                                print(data.start!.dateTime);
                                String time =
                                    data.start!.dateTime!.hour
                                        .toString() + ":" + 
                                    data.start!.dateTime!.minute
                                        .toString();
                                return Container(
                                  height: 100, 
                                  width: 140,
                                  margin: EdgeInsets.only(
                                    right: 10
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10), 
                                    color: upcoming_events.indexOf(data) != 0 ? Custom_Color.main_blue : Custom_Color.secondary
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 130,
                                        margin: EdgeInsets.only(
                                          top: 5
                                        ),
                                        color: upcoming_events.indexOf(data) != 0
                                                ? Custom_Color.brand_tint
                                                : Custom_Color.secondary_shade.withOpacity(0.5),
                                        child : Center(
                                          child: Text(
                                            time, 
                                            style: GoogleFonts.fredoka(
                                              color : Custom_Color.background, 
                                              fontWeight : FontWeight.w600, 
                                              fontSize : 40
                                            ),
                                          ),
                                        )
                                      ), 
                                      SizedBox(height: 5,),
                                      Container(
                                        width: 130, 
                                        margin: EdgeInsets.only(
                                          left: 5, 
                                          right: 3
                                        ),
                                        child: Text(
                                          data.summary!, 
                                          maxLines : 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.fredoka(
                                            color : Custom_Color.background,
                                            fontWeight : FontWeight.w600, 
                                            height : 1,
                                            fontSize : data.summary!.length < 12 ? 25 : 22 , 
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }).toList()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 30, 
              left: width * 0.05,
              width: width * 0.9,
              child: Stack(
                children: [
                  Container(
                    height: 70, 
                    margin: EdgeInsets.only(
                      top: 40
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)), 
                      color: Custom_Color.main_blue
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  AssetImage("assets/images/settings.png"), 
                                  color: Custom_Color.background,
                                  size: 35,
                                )
                              ],
                            ),
                          ),
                        ), 
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  AssetImage("assets/images/calendar.png"),
                                  color: Custom_Color.background,
                                  size: 38,
                                ),
                                
                              ],
                            ),
                          ),
                        ), 
                      ],
                    ),
                  ),
                  Positioned(
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx){
                            return Add_Goal();
                          })
                        ).then((value) => null);
                      },
                      child: Container(
                        height: 70, 
                        width: 70,
                        margin: EdgeInsets.only(
                          top: 10,
                          left: 155
                        ), 
                        decoration: BoxDecoration(
                          color: Custom_Color.brand_tint, 
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: ImageIcon(
                            AssetImage("assets/images/add.png"), 
                            color: Custom_Color.background, 
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}