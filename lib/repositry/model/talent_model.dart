

class TalentModel {
  int? id;
  String? name;
  int? age;
  String? image_URL;
  int? count;
  String? job;
  String? share_name;

  int? phoneNumber;
  String? address;
  bool? isFavorite;

  TalentModel(
      {this.id,
      this.name,
      this.age,
      this.image_URL,
      this.count,
      this.job,
      this.share_name,
      this.phoneNumber,
      this.address,
      this.isFavorite});
}
