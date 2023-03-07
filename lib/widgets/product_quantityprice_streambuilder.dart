import '../screenbarrel/screen_barrel.dart';
class ProductQuantityPriceStreambuilder extends StatelessWidget {
  final Stream<Map<String, int>>? _stream;
  final String _quantityOrPrice;
  const ProductQuantityPriceStreambuilder({Key? key,required Stream<Map<String, int>>? stream,required String quantityOrPrice}) : _quantityOrPrice = quantityOrPrice, _stream = stream, super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, int>>(
        stream: _stream,
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
            '${data[_quantityOrPrice]}',
            style: TextStyle(
              fontSize: 10.sp,
            ),
          );
        });
  }
}
