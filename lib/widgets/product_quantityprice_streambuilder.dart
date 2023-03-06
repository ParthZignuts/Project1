import '../screenbarrel/screen_barrel.dart';
class ProductQuantityPriceStreambuilder extends StatelessWidget {
  final Stream<Map<String, int>>? stream;
  final String quantityOrPrice;
   ProductQuantityPriceStreambuilder({Key? key,required this.stream,required this.quantityOrPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, int>>(
        stream: stream,
        builder:
            (BuildContext context,
            AsyncSnapshot<
                Map<String,
                    int>>
            snapshot) {
          if (snapshot.hasError) {
            return Text(
                'Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const Text(
                'Loading...');
          }
          final data =
          snapshot.data!;
          return Text(
            '${data[quantityOrPrice]}',
            style: TextStyle(
              fontSize: 10.sp,
            ),
          );
        });
  }
}
