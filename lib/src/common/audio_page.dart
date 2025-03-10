import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru/yaru.dart';

import '../../app.dart';
import '../../common.dart';
import '../../data.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({
    super.key,
    required this.audios,
    required this.audioPageType,
    required this.pageId,
    this.title,
    this.controlPanelButton,
    this.headerTitle,
    this.headerSubtile,
    this.headerLabel,
    this.headerDescription,
    this.image,
    this.onAlbumTap,
    this.onArtistTap,
    this.noResultMessage,
    this.noResultIcon,
    this.titleLabel,
    this.artistLabel,
    this.albumLabel,
    this.controlPanelTitle,
    this.titleFlex = 1,
    this.artistFlex = 1,
    this.albumFlex = 1,
    this.showTrack = true,
    this.showAlbum = true,
    this.showArtist = true,
    this.imageRadius,
    this.onLabelTab,
    this.onSubTitleTab,
  });

  final Set<Audio>? audios;
  final AudioPageType audioPageType;
  final String? headerLabel;
  final String pageId;
  final String? headerTitle;
  final Widget? controlPanelTitle;
  final String? headerDescription;
  final String? headerSubtile;
  final Widget? controlPanelButton;
  final Widget? title;
  final Widget? image;
  final Widget? noResultMessage;
  final Widget? noResultIcon;
  final String? titleLabel, artistLabel, albumLabel;
  final int titleFlex, artistFlex, albumFlex;
  final bool showTrack, showAlbum, showArtist;
  final BorderRadius? imageRadius;
  final void Function(String text)? onSubTitleTab;
  final void Function(String text)? onLabelTab;
  final void Function(String text)? onAlbumTap;
  final void Function(String text)? onArtistTap;

  @override
  Widget build(BuildContext context) {
    final body = AudioPageBody(
      key: ValueKey(audios?.length),
      pageId: pageId,
      audios: audios,
      noResultMessage: noResultMessage,
      noResultIcon: noResultIcon,
      onAlbumTap: onAlbumTap,
      onArtistTap: onArtistTap,
      audioPageType: audioPageType,
      image: image,
      imageRadius: imageRadius,
      headerDescription: headerDescription,
      controlPanelButton: controlPanelButton,
      headerLabel: headerLabel,
      onLabelTab: onLabelTab,
      headerSubTitle: headerSubtile,
      onSubTitleTab: onSubTitleTab,
      headerTitle: headerTitle,
      controlPanelTitle: controlPanelTitle,
      albumFlex: albumFlex,
      titleFlex: titleFlex,
      artistFlex: artistFlex,
      titleLabel: titleLabel,
      artistLabel: artistLabel,
      albumLabel: albumLabel,
      showTrack: showTrack,
      showAlbum: showAlbum,
      showArtist: showArtist,
    );

    return Consumer(
      builder: (context, ref, _) {
        final showWindowControls =
            ref.watch(appModelProvider.select((a) => a.showWindowControls));

        return YaruDetailPage(
          key: ValueKey(pageId),
          appBar: HeaderBar(
            style: showWindowControls
                ? YaruTitleBarStyle.normal
                : YaruTitleBarStyle.undecorated,
            title: isMobile ? null : (title ?? Text(headerTitle ?? pageId)),
            leading: Navigator.canPop(context)
                ? const NavBackButton()
                : const SizedBox.shrink(),
          ),
          body: body,
        );
      },
    );
  }
}

enum AudioPageType {
  allTitlesView,
  artist,
  likedAudio,
  podcast,
  playlist,
  album,
  radio;
}
