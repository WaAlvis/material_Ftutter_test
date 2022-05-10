part of '../filters_view.dart';

class CustomSliderRange extends StatefulWidget {
  const CustomSliderRange({Key? key}) : super(key: key);

  @override
  State<CustomSliderRange> createState() => _CustomSliderRangeState();
}

class _CustomSliderRangeState extends State<CustomSliderRange> {
  RangeValues selectedRange = const RangeValues(0, 5);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final FilterViewModel viewModel = context.watch<FilterViewModel>();
    return Container(
      padding: EdgeInsets.all(20),
      child: SliderTheme(
        data: SliderThemeData(
          thumbColor: Colors.orange[700],
          rangeThumbShape: CustomRoundRangeSliderThumbShape(
              enabledThumbRadius: 18.0,
              pressedElevation: 8.0,
              elevation: 10,
              range: viewModel.status.selectRange!,
              max: 5,
              min: 0),
          activeTrackColor: Colors.grey[300],
          inactiveTrackColor: Colors.grey[200],
          trackHeight: 7.0,
          inactiveTickMarkColor: Colors.grey[200],
          activeTickMarkColor: Colors.grey[300],
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
          showValueIndicator: ShowValueIndicator.never,
        ),
        child: Column(
          children: [
            FormBuilderRangeSlider(
              // values: selectedRange,
              textStyle: textTheme.bodyMedium
                  ?.copyWith(color: LdColors.grayLight, fontSize: 24),
              min: 0,
              max: 5,
              divisions: 10,
              labels: RangeLabels(
                selectedRange.start.toString(),
                selectedRange.end.toString(),
              ),
              onChanged: (RangeValues? newRange) {
                viewModel.setRangeSlider(newRange!);
                setState(() {
                  selectedRange = newRange;
                });
              },
              onReset: () => selectedRange = RangeValues(0, 5),
              name: 'rate',
              initialValue: viewModel.status.selectRange!,
              displayValues: DisplayValues.none,
              valueTransformer: (RangeValues? rangeVal) {
                print(rangeVal);
                return '[${rangeVal!.start}, ${rangeVal.end}]';
              },
              decoration: InputDecoration(
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[Text('Calificación general')],
                ),
                // labelText: 'Cantidad DLYCOP',
                labelStyle: textTheme.bodyMedium?.copyWith(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
