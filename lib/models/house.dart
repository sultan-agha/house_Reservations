// aseme lhouse wel addres wsora 3ano

class House {
  String name;
  String address;
  String imageUrl;

  House(this.name, this.address, this.imageUrl);
// here i put the names
  static List<House> generateRecommended() {
    return [
      House('The Moon House', 'P455, Chhatak, Sylhet',
          'images/house01.jpeg'),
      House('The Moon House', 'P455, Chhatak, Sylhet',
          'images/house02.jpeg'),
    ];
  }
//for best offers
  static List<House> generateBestOffer() {
    return [
      House('The Moon House', 'P455, Chhatak, Sylhet',
          'images/offer01.jpeg'),
      House('The Moon House', 'P455, Chhatak, Sylhet',
          'images/offer02.jpeg'),
    ];
  }
}