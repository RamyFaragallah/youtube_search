library search_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:youtube_search/data/model/search/model_search.dart';
part 'search_state.g.dart';

abstract class SearchState implements Built<SearchState, SearchStateBuilder> {
  bool get loading;
  BuiltList<SearchItem> get searchitems;
  String get error;
  bool get reachedendresult;
  SearchState._();

  bool get isInitial => !loading && searchitems.isEmpty && error == '';
  bool get isSuccessful => !loading && searchitems.isNotEmpty && error == '';
  factory SearchState([updates(SearchStateBuilder b)]) = _$SearchState;
  factory SearchState.initial() {
    return SearchState((b) {
      b
        ..loading = false
        ..searchitems.replace(BuiltList<SearchItem>())
        ..error = ''
        ..reachedendresult = false;
    });
  }
  factory SearchState.loading() {
    return SearchState((b) {
      b
        ..loading = true
        ..searchitems.replace(BuiltList<SearchItem>())
        ..error = ''
        ..reachedendresult = false;
    });
  }
  factory SearchState.failed(String error) {
    return SearchState((b) {
      b
        ..loading = false
        ..searchitems.replace(BuiltList<SearchItem>())
        ..error = error
        ..reachedendresult = false;
    });
  }
  factory SearchState.succeeded(BuiltList<SearchItem> searchitem) {
    return SearchState((b) {
      b
        ..loading = false
        ..searchitems.replace(searchitem)
        ..error = ''
        ..reachedendresult = false;
    });
  }
}
