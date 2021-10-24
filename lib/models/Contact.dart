class Contact
{
  String firstName="";
  String lastName="";
  String email="";
  String id = "";
  Contact(){
    this.id = "";
    this.firstName = "";
    this.lastName = "";
    this.email = "";
  }

  Contact.fromJson(Map<String,dynamic> json)
  {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
  }
}