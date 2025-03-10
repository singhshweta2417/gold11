import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gold11/new_pages_by_harsh/all_player_view.dart';
import 'package:gold11/new_pages_by_harsh/model/live_team_preview_model.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';

class LivePlayerView extends StatelessWidget {
  final List<LiveTeamPreviewModel> wkPlayers;
  final String homeTeamId;

  const LivePlayerView({
    super.key,
    required this.wkPlayers,
    required this.homeTeamId,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: _buildPlayerRows(context),
      ),
    );
  }

  // Helper method to create player rows based on list length
  List<Widget> _buildPlayerRows(BuildContext context) {
    List<Widget> rows = [];

    // Sort players to prioritize home team players at the top
    List<LiveTeamPreviewModel> sortedPlayers = List.from(wkPlayers)
      ..sort((a, b) => (a.teamid.toString() == homeTeamId) ? -1 : 1);

    if (sortedPlayers.length == 5) {
      rows.add(_buildRow(sortedPlayers.take(3).toList(), context));
      rows.add(_buildRow(sortedPlayers.skip(3).take(2).toList(), context));
    } else if (sortedPlayers.length <= 4) {
      rows.add(_buildRow(sortedPlayers, context));
    } else {
      for (int i = 0; i < sortedPlayers.length; i += 4) {
        rows.add(_buildRow(sortedPlayers.skip(i).take(4).toList(), context));
      }
    }
    return rows;
  }

  // Helper method to build a single row of players
  Widget _buildRow(List<LiveTeamPreviewModel> players, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: players.map((player) {
        final isHomeTeam = player.teamid.toString() == homeTeamId;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => AllPlayerView(
                  matchId: player.matchid.toString(),
                  playerId: player.playerid.toString(),
                  teamId: player.myTeamid.toString(),
                  matchType: '3',
                ),
                ));

              },
              child: CachedNetworkImage(
                imageUrl: player.playerImage ?? '',
                imageBuilder: (context, imageProvider) => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (player.isCaptain == 1 || player.isViceCaptain == 1)
                      Positioned(
                        top: -5,
                        left: -8,
                        child: ContainerConst(
                          width: MediaQuery.of(context).size.width / 15,
                          padding: const EdgeInsets.all(2),
                          border: Border.all(
                            color: isHomeTeam ? AppColor.textGreyColor : AppColor.whiteColor,
                            width: 1.5,
                          ),
                          shape: BoxShape.circle,
                          color: isHomeTeam ? AppColor.whiteColor : AppColor.textGreyColor,
                          child: TextConst(
                            text: player.isCaptain == 1 ? "C" : "VC",
                            textColor: isHomeTeam ? AppColor.textGreyColor : AppColor.whiteColor,
                            fontSize: Sizes.fontSizeZero,
                          ),
                        ),
                      ),
                  ],
                ),
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: isHomeTeam ? AppColor.whiteColor : AppColor.textGreyColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  player.playerName ?? '',
                  style: GoogleFonts.mcLaren(
                    color: isHomeTeam ? Colors.black : Colors.white,
                    fontSize: 9,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${player.totalPoint} pts',
              style: GoogleFonts.mcLaren(
                color: AppColor.whiteColor,
                fontSize: 10,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
