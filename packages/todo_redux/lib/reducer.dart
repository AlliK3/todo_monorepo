

import 'package:todo_redux/actions.dart';
import 'package:todo_redux/app_state.dart';

AppState addTaskReducer(AppState state, dynamic action){
  if(action is AddTaskAction){

  }

  return state;
}

AppState appReducer(AppState state, dynamic action) {
  if (action is AddTaskAction) {
    return state.copyWith(tasks: [...state.tasks, action.task]);

  } else if (action is DeleteTaskAction) {
    final updated = [...state.tasks]..removeAt(action.index);
    return state.copyWith(tasks: updated);
    
  } else if (action is ToggleTaskAction) {
    final updated = [...state.tasks];
    final task = updated[action.index];
    updated[action.index] = task.copyWith(isChecked: !task.isChecked);
    return state.copyWith(tasks: updated);
  }

  return state;
}