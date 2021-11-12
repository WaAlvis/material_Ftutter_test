part of '../login_view.dart';

class _PrimaryButton extends StatelessWidget {

  const _PrimaryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final LoginViewModel viewModel = context.watch<LoginViewModel>();

    return ElevatedButton(
      onPressed: ()=> viewModel.goHome(context),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        'Ingresar',
        style: textTheme.textWhite,
      ),
    );
  }
}