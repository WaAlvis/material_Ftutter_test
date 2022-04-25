part of 'info_view.dart';

class _InfoMobile extends StatelessWidget {
  const _InfoMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LdAppbar(title: 'Test', centerTitle: false,),
      extendBodyBehindAppBar: true,
      body: AppbarCircles(
        hAppbar: 0,
        content: Column(
          children: [
            const Text('Hola')
          ],
        ),
      ),
    );
  }
}
