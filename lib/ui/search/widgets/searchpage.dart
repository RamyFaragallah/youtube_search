import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_search/data/model/search/search_item.dart';
import 'package:youtube_search/data/model/search/search_snippet.dart';
import 'package:youtube_search/ui/detail/detail_page.dart';
import 'package:youtube_search/ui/search/bloc/search.dart';
import 'package:youtube_search/ui/search/bloc/searchbloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:youtube_search/ui/search/widgets/centered_message.dart';
import 'package:youtube_search/ui/search/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchBloc = kiwi.Container().resolve<SearchBloc>();
  final _searchScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => _searchBloc,
        child: Scaffold(
          appBar: AppBar(
            title: SearchBar(),
          ),
          body: BlocBuilder(
            builder: (context, SearchState state) {
              if (state.isInitial) {
                return CenteredMessage(
                  message: 'Start searching!',
                  icon: Icons.ondemand_video,
                );
              }

              if (state.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.isSuccessful) {
                return _buildResultList(state);
              } else {
                return CenteredMessage(
                  message: state.error,
                  icon: Icons.error_outline,
                );
              }
            },
            bloc: _searchBloc,
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _searchBloc.close();
  }

  Widget _buildResultList(SearchState state) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.builder(
        itemCount: _calculateListItemCount(state),
        controller: _searchScroll,
        itemBuilder: (context, index) {
          return index >= state.searchitems.length
              ? _buildLoaderListItem()
              : _buildVideoListItem(state.searchitems[index]);
        },
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _searchScroll.position.extentAfter == 0) {
      _searchBloc.fetchNextResultPage();
    }
    return false;
  }

  Widget _buildVideoListItem(SearchItem searchItem) {
    return GestureDetector(
      child: _buildVideoListItemCard(searchItem.snippet),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return DetailPage(
              videoId: searchItem.id.videoId,
            );
          }),
        );
      },
    );
  }

  Widget _buildVideoListItemCard(SearchSnippet videoSnippet) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                videoSnippet.thumbnails.high.url,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Text(
              videoSnippet.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 5),
            Text(
              videoSnippet.description,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoaderListItem() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  int _calculateListItemCount(SearchState state) {
    if (state.reachedendresult) {
      return state.searchitems.length;
    } else {
      return state.searchitems.length + 1;
    }
  }
}
