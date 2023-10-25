import 'dart:ffi';

class Achievement {
    String name;
    String description;
    bool status;

  Achievement({required this.name, required this.description,required this.status});

  setName(String newName){
    name = newName;
  }
  setdescription(String newDescription){
    description = newDescription;
  }
  setstatus(bool newStatus){
    status = newStatus;
  }
  Achievement.defaultValues()
      : name = '',
        description = '',
        status = false;
}