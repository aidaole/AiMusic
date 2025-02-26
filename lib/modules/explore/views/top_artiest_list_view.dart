import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/log_util.dart';
import '../../../common/widgets/common_circle_loading.dart';
import '../../../common/widgets/common_network_image.dart';
import '../../../routes/app_routes.dart';
import '../../../routes/route_helper.dart';
import '../bloc/play_list_bloc.dart';
import '../bloc/play_list_state.dart';

class TopArtiestListView extends StatefulWidget {
  const TopArtiestListView({super.key});

  @override
  State<TopArtiestListView> createState() => _TopArtiestListViewState();
}

class _TopArtiestListViewState extends State<TopArtiestListView> {
  final String _tag = "TopArtiestListView";

  @override
  Widget build(BuildContext context) {
    return _buildTopArtistListBloc(context);
  }

  _buildTopArtistListBloc(BuildContext context) {
    const borderColor = Color(0xFFE80063);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "推荐歌手",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<PlayListBloc, PlayListState>(
          buildWhen: (previous, current) =>
              current is RequestTopArtistsSuccess ||
              current is RequestTopArtistsLoading ||
              current is RequestTopArtistsError,
          builder: (context, state) {
            logd("state: $state", tag: _tag);
            if (state is RequestTopArtistsLoading) {
              return const Center(child: CommonCircleLoading());
            }
            if (state is RequestTopArtistsError) {
              return Center(child: Text(state.error));
            }
            if (state is RequestTopArtistsSuccess) {
              return _buildTopArtistList(state, borderColor);
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  SizedBox _buildTopArtistList(
      RequestTopArtistsSuccess state, Color borderColor) {
    return SizedBox(
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              RouteHelper.push(context, AppRoutes.artiestDetail,
                  arguments: state.topArtists.artists?[index].id);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Stack(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CommonNetworkImage(
                      imageUrl: "${state.topArtists.artists?[index].img1v1Url}",
                      width: 80,
                      height: 80,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 45,
                      margin: const EdgeInsets.symmetric(horizontal: 17),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: borderColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${state.topArtists.artists?[index].name}",
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
