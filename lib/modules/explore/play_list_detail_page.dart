import 'package:ai_music/themes/theme_color.dart';
import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';

import '../../common/log_util.dart';
import '../../routes/route_helper.dart';
import '../../themes/theme_size.dart';

class PlayListDetailPage extends StatelessWidget {
  static const String _tag = 'PlayListDetailPage';
  const PlayListDetailPage({super.key, required this.playListId});
  final int playListId;

  @override
  Widget build(BuildContext context) {
    logd('playListId: $playListId', tag: _tag);
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const StatusBarPlaceHolder(),
        _buildActionBar(context),
        _buildContent(),
      ],
    );
  }

  Widget _buildActionBar(BuildContext context) {
    return SizedBox(
      height: defaultActionBarHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              RouteHelper.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Container(),
    );
  }
}
