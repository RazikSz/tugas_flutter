import 'package:json_annotation/json_annotation.dart';

part 'post_models.g.dart';

@JsonSerializable()
class RecipeResponse {
  @JsonKey(name: 'recipes')
  final List<RecipeModel>? recipes;

  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'skip')
  final int? skip;

  @JsonKey(name: 'limit')
  final int? limit;

  RecipeResponse({
    this.recipes,
    this.total,
    this.skip,
    this.limit,
  });

  factory RecipeResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeResponseToJson(this);
}

@JsonSerializable()
class RecipeModel {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'ingredients')
  final List<String>? ingredients;

  @JsonKey(name: 'instructions')
  final List<String>? instructions;

  @JsonKey(name: 'prepTimeMinutes')
  final int? prepTimeMinutes;

  @JsonKey(name: 'cookTimeMinutes')
  final int? cookTimeMinutes;

  @JsonKey(name: 'servings')
  final int? servings;

  @JsonKey(name: 'difficulty')
  final String? difficulty;

  @JsonKey(name: 'cuisine')
  final String? cuisine;

  @JsonKey(name: 'caloriesPerServing')
  final int? caloriesPerServing;

  @JsonKey(name: 'tags')
  final List<String>? tags;

  @JsonKey(name: 'userId')
  final int? userId;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'mealType')
  final List<String>? mealType;

  RecipeModel({
    this.id,
    this.name,
    this.ingredients,
    this.instructions,
    this.prepTimeMinutes,
    this.cookTimeMinutes,
    this.servings,
    this.difficulty,
    this.cuisine,
    this.caloriesPerServing,
    this.tags,
    this.userId,
    this.image,
    this.rating,
    this.reviewCount,
    this.mealType,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);
}

typedef PostModels = RecipeModel;
typedef CocktailResponse = RecipeResponse;
typedef DrinkModel = RecipeModel;
