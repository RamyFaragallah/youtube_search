import 'package:bloc/bloc.dart';
import 'package:youtube_search/data/model/search/model_search.dart';
import 'package:youtube_search/data/repository/youtube_repository.dart';
import 'search.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final YoutubeRepository _youtubeRepository;

  void onSearchInitiated(String query) {
    add(SearchInitiated((b) => b..query = query));
  }

  void fetchNextResultPage() {
    add(FetchNextPage());
  }

  SearchBloc(this._youtubeRepository) : super();
  @override
  SearchState get initialState => SearchState.initial();

  Stream<SearchState> mapSearchInitiated(SearchInitiated event) async* {
    if (event.query.isEmpty) {
      yield SearchState.initial();
    } else {
      yield SearchState.loading();

      try {
        final searchResult = await _youtubeRepository.searchVideos(event.query);
        yield SearchState.succeeded(searchResult);
      } on YoutubeSearchError catch (e) {
        yield SearchState.failed(e.errormessage);
      } on NoSearchResultsException catch (e) {
        yield SearchState.failed(e.message);
      }
    }
  }

  Stream<SearchState> mapFetchNextResultPage() async* {
    try {
      final nextPageResults = await _youtubeRepository.fetchNextResultPage();
      yield SearchState.succeeded(state.searchitems + nextPageResults);
    } on NoNextPageTokenException catch (_) {
      yield state.rebuild((b) => b..reachedendresult = true);
    } on SearchNotInitiatedException catch (e) {
      yield SearchState.failed(e.message);
    } on YoutubeSearchError catch (e) {
      yield SearchState.failed(e.errormessage);
    }
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchInitiated) {
      yield* mapSearchInitiated(event);
    } else if (event is FetchNextPage) {
      yield* mapFetchNextResultPage();
    }
  }
}
