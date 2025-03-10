import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gold11/model/team_data_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gold11/new_pages_by_harsh/all_player_view.dart';
import 'package:gold11/res/color_const.dart';
import 'package:gold11/res/sizes_const.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view/const_widget/text_const.dart';

class WicketKeeperWidget extends StatefulWidget {
  final List<TeamPlayerList> wkPlayers;
  final TeamData data;

  const WicketKeeperWidget({
    super.key,
    required this.wkPlayers,
    required this.data,
  });

  @override
  State<WicketKeeperWidget> createState() => _WicketKeeperWidgetState();
}

class _WicketKeeperWidgetState extends State<WicketKeeperWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: _buildPlayerRows(context),
      ),
    );
  }

  List<Widget> _buildPlayerRows(BuildContext context) {
    List<Widget> rows = [];
    if (widget.wkPlayers.length == 5) {
      rows.add(_buildRow(widget.wkPlayers.take(3).toList(), context));
      rows.add(_buildRow(widget.wkPlayers.skip(3).take(2).toList(), context));
    } else if (widget.wkPlayers.length <= 4) {
      rows.add(_buildRow(widget.wkPlayers, context));
    } else {
      for (int i = 0; i < widget.wkPlayers.length; i += 4) {
        rows.add(_buildRow(widget.wkPlayers.skip(i).take(4).toList(), context));
      }
    }

    return rows;
  }

  Widget _buildRow(List<TeamPlayerList> players, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: players.map((wK) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                widget.data.matchStatus == 2 || widget.data.matchStatus == 3
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllPlayerView(
                                  matchId: wK.matchId.toString(),
                                  playerId: wK.playerId.toString(),
                                  teamId: wK.myTeamId.toString(),
                                  matchType: '3',
                                )))
                    : Utils.showErrorMessage(context,
                        'Player points  updated only the after the match start');
              },
              child: CachedNetworkImage(
                imageUrl: wK.playerImage.toString(),
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
                    if (wK.isCaptain == 1 || wK.isViceCaptain == 1)
                      Positioned(
                        top: -5,
                        left: -8,
                        child: ContainerConst(
                          width: MediaQuery.of(context).size.width / 15,
                          padding: const EdgeInsets.all(2),
                          border: Border.all(
                            color: widget.data.homeTeamId.toString() !=
                                    wK.teamId.toString()
                                ? AppColor.whiteColor
                                : AppColor.textGreyColor,
                            width: 1.5,
                          ),
                          shape: BoxShape.circle,
                          color: widget.data.homeTeamId.toString() !=
                                  wK.teamId.toString()
                              ? AppColor.textGreyColor
                              : AppColor.whiteColor,
                          child: TextConst(
                            text: (wK.isCaptain == 1) ? "C" : 'VC',
                            textColor: widget.data.homeTeamId.toString() !=
                                    wK.teamId.toString()
                                ? AppColor.whiteColor
                                : AppColor.textGreyColor,
                            fontSize: Sizes.fontSizeZero,
                          ),
                        ),
                      ),
                  ],
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
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
                color: widget.data.homeTeamId.toString() != wK.teamId.toString()
                    ? AppColor.textGreyColor
                    : AppColor.whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  wK.playerName.toString(),
                  style: GoogleFonts.mcLaren(
                    color: widget.data.homeTeamId.toString() !=
                            wK.teamId.toString()
                        ? Colors.white
                        : Colors.black,
                    fontSize: 9,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${wK.totalPoint} pts',
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
