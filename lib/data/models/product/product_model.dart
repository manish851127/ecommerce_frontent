class ProductModel {
  String? sId;
  String? category;
  String? title;
  int? price;
  List<String>? images;
  String? description;
  String? updatedOn;
  String? createdOn;

  ProductModel(
      {this.sId,
      this.category,
      this.title,
      this.price,
      this.images,
      this.description,
      this.updatedOn,
      this.createdOn});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    title = json['title'];
    price = json['price'];
    images = json['images'].cast<String>();
    description = json['description'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category'] = this.category;
    data['title'] = this.title;
    data['price'] = this.price;
    data['images'] = this.images;
    data['description'] = this.description;
    data['updatedOn'] = this.updatedOn;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
