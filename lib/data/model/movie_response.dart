import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {

	@JsonKey(name: "results")
	List<MovieResponseData>? data;

	@JsonKey(name: "q")
	String? query;

	MovieResponse({this.data, this.query});

	factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);

	Map<String, dynamic> toJson() => _$MovieResponseToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MovieResponseData {
	MovieResponseImage? image;
	String? id;
	String? title;
	String? titleType;
	String? actors;
	int? year;
	String? yearRange;

	MovieResponseData({this.image, this.id,this.title,this.titleType, this.actors,this.yearRange,this.year});
	//
	factory MovieResponseData.fromJson(Map<String, dynamic> json) => _$MovieResponseDataFromJson(json);

	Map<String, dynamic> toJson() => _$MovieResponseDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MovieResponseImage {
	int? height;

	@JsonKey(name: "url")
	String? imageUrl;

	int? width;

	MovieResponseImage();
	//
	factory MovieResponseImage.fromJson(Map<String, dynamic> json) => _$MovieResponseImageFromJson(json);

	Map<String, dynamic> toJson() => _$MovieResponseImageToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
