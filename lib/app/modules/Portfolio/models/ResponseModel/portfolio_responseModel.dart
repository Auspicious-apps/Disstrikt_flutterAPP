class PortfolioResponseModel {
  bool? success;
  String? message;
  PortfolioData? data;

  PortfolioResponseModel({this.success, this.message, this.data});

  PortfolioResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? new PortfolioData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PortfolioData {
  String? userId;
  String? sId;
  String? fullName;
  String? image;
  String? aboutMe;
  List<String>? portfolioImages;
  List<PortfolioLinks>? links;
  List<String>? setCards;
  List<Videos>? videos;
  String? portfolioLink;
  List<String>? videoSections;

  PortfolioData(
      {this.userId,
      this.sId,
      this.fullName,
      this.image,
      this.aboutMe,
      this.setCards,
      this.portfolioImages,
      this.links,
      this.videos,
      this.portfolioLink,
      this.videoSections});

  PortfolioData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    sId = json['_id'];
    fullName = json['fullName'];
    image = json['image'];
    aboutMe = json['aboutMe'];
    setCards = json['setCards'].cast<String>();
    portfolioImages = json['portfolioImages'].cast<String>();
    if (json['links'] != null) {
      links = <PortfolioLinks>[];
      json['links'].forEach((v) {
        links!.add(new PortfolioLinks.fromJson(v));
      });
    }

    portfolioLink = json['portfolioLink'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    videoSections = json['videoSections'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['_id'] = this.sId;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    data['fullName'] = this.fullName;
    data['image'] = this.image;
    data['aboutMe'] = this.aboutMe;
    data['setCards'] = this.setCards;
    data['portfolioImages'] = this.portfolioImages;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }

    data['portfolioLink'] = this.portfolioLink;
    data['videoSections'] = this.videoSections;
    return data;
  }
}

class Videos {
  String? title;
  String? url;
  String? thumbnail;
  String? sId;

  Videos({this.title, this.url, this.thumbnail, this.sId});

  Videos.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    thumbnail = json['thumbnail'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnail'] = this.thumbnail;
    data['_id'] = this.sId;
    return data;
  }
}

class PortfolioLinks {
  String? platform;
  String? url;

  PortfolioLinks({this.platform, this.url});

  PortfolioLinks.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['platform'] = this.platform;
    data['url'] = this.url;
    return data;
  }
}
