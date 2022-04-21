part of '../attached_file_view.dart';

class OperationHeader extends StatelessWidget {
  const OperationHeader({
    Key? key,
    required this.textTheme,
    required this.size,
  }) : super(key: key);

  final TextTheme textTheme;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Archivo adjunto',
          style: textTheme.subtitleBlack.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
