import 'dart:convert';

MovieListModel movieListModelFromJson(String str) =>
    MovieListModel.fromJson(json.decode(str));

String movieListModelToJson(MovieListModel data) => json.encode(data.toJson());

class MovieListModel {
  String? total;
  int? page;
  int? pages;
  List<TvShow>? tvShows;

  MovieListModel({
    this.total,
    this.page,
    this.pages,
    this.tvShows,
  });

  factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
        total: json["total"] as String?,
        page: json["page"] as int?,
        pages: json["pages"] as int?,
        tvShows: json["tv_shows"] == null
            ? []
            : List<TvShow>.from(
                json["tv_shows"].map((x) => TvShow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "pages": pages,
        "tv_shows": tvShows == null
            ? []
            : List<dynamic>.from(tvShows!.map((x) => x.toJson())),
      };
}

class TvShow {
  int? id;
  String? name;
  String? permalink;
  DateTime? startDate;
  dynamic endDate;
  String? country;
  String? network;
  String? status;
  String? imageThumbnailPath;

  TvShow({
    this.id,
    this.name,
    this.permalink,
    this.startDate,
    this.endDate,
    this.country,
    this.network,
    this.status,
    this.imageThumbnailPath,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) => TvShow(
        id: json["id"],
        name: json["name"],
        permalink: json["permalink"],
        startDate: json["start_date"] != null
            ? DateTime.tryParse(json["start_date"])
            : null,
        endDate: json["end_date"],
        country: json["country"],
        network: json["network"],
        status: json["status"],
        imageThumbnailPath: json["image_thumbnail_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "permalink": permalink,
        "start_date": startDate != null
            ? "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}"
            : null,
        "end_date": endDate,
        "country": country,
        "network": network,
        "status": status,
        "image_thumbnail_path": imageThumbnailPath,
      };
}
