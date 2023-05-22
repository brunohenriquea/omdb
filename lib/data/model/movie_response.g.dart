// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) =>
    MovieResponse(
      data: (json['results'] as List<dynamic>?)
          ?.map((e) => MovieResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      query: json['q'] as String?,
    );

Map<String, dynamic> _$MovieResponseToJson(MovieResponse instance) =>
    <String, dynamic>{
      'results': instance.data,
      'q': instance.query,
    };

MovieResponseData _$MovieResponseDataFromJson(Map<String, dynamic> json) =>
    MovieResponseData(
      image: json['image'] == null
          ? null
          : MovieResponseImage.fromJson(json['image'] as Map<String, dynamic>),
      id: json['id'] as String?,
      title: json['title'] as String?,
      titleType: json['titleType'] as String?,
      actors: json['actors'] as String?,
      yearRange: json['yearRange'] as String?,
      year: json['year'] as int?,
    );

Map<String, dynamic> _$MovieResponseDataToJson(MovieResponseData instance) =>
    <String, dynamic>{
      'image': instance.image,
      'id': instance.id,
      'title': instance.title,
      'titleType': instance.titleType,
      'actors': instance.actors,
      'year': instance.year,
      'yearRange': instance.yearRange,
    };

MovieResponseImage _$MovieResponseImageFromJson(Map<String, dynamic> json) =>
    MovieResponseImage()
      ..height = json['height'] as int?
      ..imageUrl = json['url'] as String?
      ..width = json['width'] as int?;

Map<String, dynamic> _$MovieResponseImageToJson(MovieResponseImage instance) =>
    <String, dynamic>{
      'height': instance.height,
      'url': instance.imageUrl,
      'width': instance.width,
    };
