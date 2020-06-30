import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_search/data/model/search/model_search.dart';
import 'package:youtube_search/data/repository/youtube_repository.dart';

import 'detail.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  YoutubeRepository repository;

  DetailBloc(this.repository);

  void onShowDetail({@required String id}) {
    add(ShowDetail((b) => b..id = id));
  }

  @override
  DetailState get initialState => DetailState.initial();

  @override
  Stream<DetailState> mapEventToState(
    DetailEvent event,
  ) async* {
    if (event is ShowDetail) {
      yield DetailState.loading();
      try {
        final videoItem = await repository.fetchVideoInfo(id: event.id);
        print(videoItem.videoSnippet.title);
        yield DetailState.success(videoItem);
      } on YoutubeSearchError catch (e) {
        yield DetailState.failure(e.errormessage);
      } on NoSuchVideoException catch (e) {
        yield DetailState.failure(e.message);
      }
    }
  }
}
