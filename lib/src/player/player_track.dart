import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../build_context_x.dart';
import '../../utils.dart';
import 'player_model.dart';

class PlayerTrack extends StatelessWidget {
  const PlayerTrack({
    super.key,
    this.bottomPlayer = false,
    this.active = true,
  });

  final bool bottomPlayer, active;

  @override
  Widget build(BuildContext context) {
    final theme = context.t;

    final playerModel = context.read<PlayerModel>();

    final position = context.select((PlayerModel m) => m.position);
    final setPosition = playerModel.setPosition;
    final duration = context.select((PlayerModel m) => m.duration);
    final seek = playerModel.seek;

    bool sliderActive = active &&
        (duration != null &&
            position != null &&
            duration.inSeconds > position.inSeconds);

    final textStyle =
        TextStyle(fontSize: 12, color: !active ? theme.disabledColor : null);
    final slider = Tooltip(
      preferBelow: false,
      message:
          '${formatTime(position ?? Duration.zero)} / ${formatTime(duration ?? Duration.zero)}',
      child: SliderTheme(
        data: theme.sliderTheme.copyWith(
          thumbColor: Colors.white,
          thumbShape: const RoundSliderThumbShape(
            elevation: 0,
            enabledThumbRadius: 0,
            disabledThumbRadius: 0,
            pressedElevation: 0,
          ),
          minThumbSeparation: 0,
          trackShape: bottomPlayer ? const RectangularSliderTrackShape() : null,
          trackHeight: bottomPlayer ? 4 : 2,
          inactiveTrackColor: theme.colorScheme.onSurface.withOpacity(0.35),
          activeTrackColor: theme.colorScheme.onSurface.withOpacity(0.8),
          overlayColor: theme.colorScheme.onSurface,
          overlayShape: RoundSliderThumbShape(
            elevation: 3,
            enabledThumbRadius: bottomPlayer ? 0 : 5.0,
            disabledThumbRadius: bottomPlayer ? 0 : 5.0,
          ),
        ),
        child: RepaintBoundary(
          child: Slider(
            min: 0,
            max: sliderActive ? duration.inSeconds.toDouble() : 1.0,
            value: sliderActive ? position.inSeconds.toDouble() : 0,
            onChanged: sliderActive
                ? (v) async {
                    setPosition(Duration(seconds: v.toInt()));
                    await seek();
                  }
                : null,
          ),
        ),
      ),
    );

    if (bottomPlayer) {
      return slider;
    }

    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RepaintBoundary(
              child: SizedBox(
                width: 40,
                height: 15,
                child: Text(
                  formatTime(position ?? Duration.zero),
                  style: textStyle,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: bottomPlayer ? 0 : 3),
            child: slider,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RepaintBoundary(
              child: SizedBox(
                width: 40,
                height: 15,
                child: Text(
                  formatTime(duration ?? Duration.zero),
                  style: textStyle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
