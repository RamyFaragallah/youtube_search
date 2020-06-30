// GENERATED CODE - DO NOT MODIFY BY HAND

part of video_item;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<VideoItem> _$videoItemSerializer = new _$VideoItemSerializer();

class _$VideoItemSerializer implements StructuredSerializer<VideoItem> {
  @override
  final Iterable<Type> types = const [VideoItem, _$VideoItem];
  @override
  final String wireName = 'VideoItem';

  @override
  Iterable<Object> serialize(Serializers serializers, VideoItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'videoSnippet',
      serializers.serialize(object.videoSnippet,
          specifiedType: const FullType(VideoSnippet)),
    ];

    return result;
  }

  @override
  VideoItem deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VideoItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'videoSnippet':
          result.videoSnippet.replace(serializers.deserialize(value,
              specifiedType: const FullType(VideoSnippet)) as VideoSnippet);
          break;
      }
    }

    return result.build();
  }
}

class _$VideoItem extends VideoItem {
  @override
  final String id;
  @override
  final VideoSnippet videoSnippet;

  factory _$VideoItem([void Function(VideoItemBuilder) updates]) =>
      (new VideoItemBuilder()..update(updates)).build();

  _$VideoItem._({this.id, this.videoSnippet}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('VideoItem', 'id');
    }
    if (videoSnippet == null) {
      throw new BuiltValueNullFieldError('VideoItem', 'videoSnippet');
    }
  }

  @override
  VideoItem rebuild(void Function(VideoItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VideoItemBuilder toBuilder() => new VideoItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VideoItem &&
        id == other.id &&
        videoSnippet == other.videoSnippet;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), videoSnippet.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('VideoItem')
          ..add('id', id)
          ..add('videoSnippet', videoSnippet))
        .toString();
  }
}

class VideoItemBuilder implements Builder<VideoItem, VideoItemBuilder> {
  _$VideoItem _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  VideoSnippetBuilder _videoSnippet;
  VideoSnippetBuilder get videoSnippet =>
      _$this._videoSnippet ??= new VideoSnippetBuilder();
  set videoSnippet(VideoSnippetBuilder videoSnippet) =>
      _$this._videoSnippet = videoSnippet;

  VideoItemBuilder();

  VideoItemBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _videoSnippet = _$v.videoSnippet?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VideoItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$VideoItem;
  }

  @override
  void update(void Function(VideoItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$VideoItem build() {
    _$VideoItem _$result;
    try {
      _$result =
          _$v ?? new _$VideoItem._(id: id, videoSnippet: videoSnippet.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'videoSnippet';
        videoSnippet.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'VideoItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
