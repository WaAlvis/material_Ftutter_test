part of '../login_view.dart';

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton(
    this.data, {
    Key? key, this.colorButton=LdColors.orangePrimary, required this.onPressed,
  }) : super(key: key);

  final String data;
  final Color colorButton;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final LoginViewModel viewModel = context.watch<LoginViewModel>();

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: colorButton,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        data,
        style: textTheme.textWhite,
      ),
    );
  }
}
