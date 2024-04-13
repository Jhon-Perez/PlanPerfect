enum Gender{Male, Female, Other, None}
class Goal_Data{
  String goal_name;
  String context;
  Gender gender;
  String height;
  String weight;
  String age;
  String bp;
  Goal_Data({this.bp = "", this.goal_name = "", this.context = "", this.gender = Gender.None , this.height = "0", this.weight = "0", this.age = "0"});
}

class Training_Drill{
  String name;
  String description;
  String intensity;
  String duration;
  String equipment;
  String how_to;
  String cooldown;
  Training_Drill({this.name = "", this.description = "", this.intensity = "", this.equipment = "", this.how_to = "", this.duration = "", this.cooldown = ""});
  void parse_json(Map json){
    print(json);
    this.name = json["Name"];
    this.description = json["Description"];
    this.intensity = json["Intensity"];
    this.duration = json["Duration"];
    this.equipment = json["Equipment"];
    this.how_to = json["How_to"];
    this.cooldown = json["Cooldown"];
  }
}