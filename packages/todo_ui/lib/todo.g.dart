// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoListImpl _$$TodoListImplFromJson(Map<String, dynamic> json) =>
    _$TodoListImpl(
      (json['tasks'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TodoListImplToJson(_$TodoListImpl instance) =>
    <String, dynamic>{
      'tasks': instance.tasks,
    };
