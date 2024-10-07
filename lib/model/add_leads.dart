



class AddLeadsData {
   String? _name;
   AddLeadsData({
      String? name,

   })  : _name = name;
   String? get name => _name;


   // Factory method to create an instance from JSON
   factory AddLeadsData.fromJson(Map<String, dynamic> json) {
      return AddLeadsData(
         name: json['name'] as String?,
      );
   }
}

