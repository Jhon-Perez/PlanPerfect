import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haghocks/backend/generate.dart';
import 'package:haghocks/global_info.dart';
import 'package:haghocks/models/goal.dart';

class Add_Goal extends StatefulWidget {
  const Add_Goal({super.key});

  @override
  State<Add_Goal> createState() => _Add_GoalState();
}

class _Add_GoalState extends State<Add_Goal> {
  @override
  TextEditingController enter_goal = TextEditingController();
  TextEditingController extra_context = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height_tec = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController blood_pressure = TextEditingController();
  
  Goal_Data cur_goal_data = Goal_Data();

  List<Training_Drill> training_drills = [];

  int current_page = 0;
  bool loading = false;
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height, 
            width: width,
            color: Custom_Color.background,
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Expanded(
                  child: Container(
                    width: width,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 15,),
                            InkWell(
                              onTap: (){
                                if (current_page == 1)
                                  current_page = 0;
                                else
                                  print("");
                                setState(() {});
                              },
                              child: Container(
                                height: 60, 
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), 
                                  color: Custom_Color.secondary
                                ),
                                child: Center(
                                  child: ImageIcon(
                                    current_page == 0 ? AssetImage("assets/images/close.png"):AssetImage("assets/images/back.png"), 
                                    color: Custom_Color.background, 
                                    size : 25,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ), 
                            InkWell(
                              onTap: () async {
                                if(current_page == 0){
                                  current_page = 1;
                                  cur_goal_data.goal_name = enter_goal.text;
                                  cur_goal_data.context = enter_goal.text;
                                  cur_goal_data.weight = weight.text;
                                  cur_goal_data.height = height_tec.text;
                                  cur_goal_data.age = age.text;
                                  cur_goal_data.bp = blood_pressure.text;
                                  // Getting the ChatGPT Goods
                                  setState(() {
                                    loading = true;
                                  });
                                  print("processing...");
                                  var data = await getCompletion(cur_goal_data.goal_name, cur_goal_data.context + "Here is my age " + cur_goal_data.age + "Here is my weight in kg " + cur_goal_data.weight + "Here is my height in meters " + cur_goal_data.height + "Here is my gender " + cur_goal_data.gender.toString() + "Here is my blood pressure in mmhg " + cur_goal_data.bp, false);
                                  for(var exc in data){
                                    Training_Drill drill = Training_Drill();
                                    drill.parse_json(exc);
                                    training_drills.add(drill);
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                  print(training_drills);
                                }
                                else print("");
                                setState(() {
                                });
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Custom_Color.main_blue
                                ),
                                child : Center(
                                  child: ImageIcon(
                                    current_page == 0 ? AssetImage("assets/images/next.png") : AssetImage("assets/images/check.png"),
                                    color: Custom_Color.background,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ), 
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ), 
                        Expanded(
                          child: current_page == 0 ? InitialData(cur_goal_data, enter_goal, extra_context, weight, height_tec, age, blood_pressure) : Possible_Workouts(training_drills),
                        )
                      ],
                    ),
                  ),
                ), 
              ],
            ),
          ),
          loading ? Container(
            height: height,
            width: width, 
            color : Colors.black.withOpacity(0.6),
            child: Center(
              child: CircularProgressIndicator(color: Custom_Color.main_blue,),
            ),
          ) : Container()
        ],
      ),
    );
  }
}

class InitialData extends StatefulWidget {
  Goal_Data cur_goal_data;
  TextEditingController enter_goal = TextEditingController();
  TextEditingController extra_context = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height_tec = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController blood_pressure = TextEditingController();
  InitialData(this.cur_goal_data, this.enter_goal, this.extra_context, this.weight, this.height_tec, this.age, this.blood_pressure);
  @override
  State<InitialData> createState() => _InitialDataState();
}

class _InitialDataState extends State<InitialData> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height, 
      width: width, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 15, 
              top: 10
            ),
            child: Text(
              "Create",
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  color: Custom_Color.text,
                  fontWeight: FontWeight.w800,
                  fontSize: 55),
            ),
          ), 
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10
            ),
            child: TextField(
              style: GoogleFonts.fredoka(
                fontSize: 28, 
                fontWeight : FontWeight.w600,
                height: 0.8
              ),
              controller: widget.enter_goal,
              decoration: InputDecoration(
                hintText: 'Enter your goal',
                filled: true,
                fillColor: Custom_Color.background_shade.withOpacity(0.6),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 4),
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 4),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ), 
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              style: GoogleFonts.fredoka(
                  fontSize: 24, fontWeight: FontWeight.w600, height: 1.3),
              minLines: 6, //Normal textInputField will be displayed
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              controller: widget.extra_context,
              decoration: InputDecoration(
                hintText: 'Enter extra context about your current stat to help our AI model!',
                filled: true,
                fillColor: Custom_Color.background_shade.withOpacity(0.6),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 4),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ), 
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(width: 10,),
              Expanded(
                child: InkWell(
                  onTap: (){
                    setState(() {
                      widget.cur_goal_data.gender = Gender.Male;
                    });
                  },
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      color: widget.cur_goal_data.gender == Gender.Male
                          ? Custom_Color.main_blue
                          : Custom_Color.background_shade.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10), 
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(
                          AssetImage("assets/images/male.png"), 
                          color: widget.cur_goal_data.gender == Gender.Male
                              ? Custom_Color.background
                              : Custom_Color.text, 
                          size: 32,
                        ), 
                        SizedBox(width: 5,), 
                        Text(
                          "Boy", 
                          style: GoogleFonts.fredoka(
                            color : widget.cur_goal_data.gender == Gender.Male ? Custom_Color.background : Custom_Color.text, 
                            fontSize : 30, 
                            fontWeight : FontWeight.w600
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ), 
              SizedBox(width: 5,),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.cur_goal_data.gender = Gender.Other;
                    });
                  },
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      color: widget.cur_goal_data.gender == Gender.Other ? Custom_Color.main_blue : Custom_Color.background_shade.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(
                          AssetImage("assets/images/other.png"),
                          color: widget.cur_goal_data.gender == Gender.Other
                              ? Custom_Color.background
                              : Custom_Color.text,
                          size: 32,
                        ),
                        
                        Text(
                          "Other",
                          style: GoogleFonts.fredoka(
                              color: widget.cur_goal_data.gender == Gender.Other
                                  ? Custom_Color.background
                                  : Custom_Color.text,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ), 
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.cur_goal_data.gender = Gender.Female;
                    });
                  },
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      color: widget.cur_goal_data.gender == Gender.Female
                          ? Custom_Color.main_blue
                          : Custom_Color.background_shade.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(
                          AssetImage("assets/images/female.png"),
                          color: widget.cur_goal_data.gender == Gender.Female
                              ? Custom_Color.background
                              : Custom_Color.text,
                          size: 32,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Girl",
                          style: GoogleFonts.fredoka(
                              color: widget.cur_goal_data.gender == Gender.Female
                                  ? Custom_Color.background
                                  : Custom_Color.text,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ), 
              SizedBox(
                width: 10
              ),
            ],
          ), 
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                margin: EdgeInsets.only(left: 10, right : 4),
                child: TextField(
                    style: GoogleFonts.fredoka(
                        fontSize: 28, fontWeight: FontWeight.w600, height: 0.8),
                    controller: widget.weight,
                    decoration: InputDecoration(
                      hintText: 'Weight(kg)',
                      filled: true,
                      fillColor: Custom_Color.background_shade.withOpacity(0.6),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ), 
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 10, left: 4),
                  child: TextField(
                    style: GoogleFonts.fredoka(
                        fontSize: 28, fontWeight: FontWeight.w600, height: 0.8),
                    controller: widget.height_tec,
                    decoration: InputDecoration(
                      hintText: 'Height(m)',
                      filled: true,
                      fillColor: Custom_Color.background_shade.withOpacity(0.6),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 4),
                  child: TextField(
                    style: GoogleFonts.fredoka(
                        fontSize: 28, fontWeight: FontWeight.w600, height: 0.8),
                    controller: widget.age,
                    decoration: InputDecoration(
                      hintText: 'Age',
                      filled: true,
                      fillColor: Custom_Color.background_shade.withOpacity(0.6),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 10, left: 4),
                  child: TextField(
                    style: GoogleFonts.fredoka(
                        fontSize: 28, fontWeight: FontWeight.w600, height: 0.8),
                    controller: widget.blood_pressure,
                    decoration: InputDecoration(
                      hintText: 'BP(mmHg)',
                      filled: true,
                      fillColor: Custom_Color.background_shade.withOpacity(0.6),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Drill_Widget extends StatefulWidget {
  Training_Drill drill;
  Drill_Widget(this.drill);
  @override
  State<Drill_Widget> createState() => _Drill_WidgetState();
}

class _Drill_WidgetState extends State<Drill_Widget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 130,
      width: width * 0.98,
      margin: EdgeInsets.only(
        bottom: 10, 
        left: 10, 
        right: 10
      ),
      decoration: BoxDecoration(
        color: Custom_Color.background_shade.withOpacity(0.6), 
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 250,
                margin: EdgeInsets.only(
                  top: 10, 
                  left: 20
                ),
                child: Text(
                  widget.drill.name, 
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.fredoka(
                    color : Custom_Color.main_blue, 
                    fontWeight : FontWeight.w700, 
                    fontSize : 35, 
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Possible_Workouts extends StatefulWidget {
  List<Training_Drill> drills;

  Possible_Workouts(this.drills);

  @override
  State<Possible_Workouts> createState() => _Possible_WorkoutsState();
}

class _Possible_WorkoutsState extends State<Possible_Workouts> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height, 
        width: width,
        color: Custom_Color.background,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                right: 200, 
                top: 20, 
                bottom: 10
              ),
              child: Text(
                "Create",
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                    height : 1,
                    color: Custom_Color.text,
                    fontWeight: FontWeight.w800,
                    fontSize: 55),
              ),
            ), 
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ...widget.drills.map((data) {
                      print(data.name);
                      return Drill_Widget(data);
                    }).toList()
                  ],
                ),
              ),
            )
          ],
        )
      )
    );
  }
}