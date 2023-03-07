
import '../../../screenbarrel/screen_barrel.dart';

class ProductDetailScreen extends StatefulWidget {
  static const id = "productdetailscreen";
  final String? uid;
  final String? wishId;

  const ProductDetailScreen({Key? key, this.uid, this.wishId}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref('product'); //realtime database reference
  final ListController _listController = ListController(); //Controller Reference
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text('ProductDetailScreen'),
      ),
      body: Scaffold(
        body: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return SizedBox(
              height: 140.h,
              child: Card(
                child: Row(
                  children: [
                    Container(
                      height: 170.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(snapshot.child('image').value.toString()),
                              fit: BoxFit.cover),
                          borderRadius:BorderRadius.all(const Radius.circular(4).w)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.lightGreen,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(2.w),
                                  bottomRight: Radius.circular(15.w)),
                            ),
                            padding: const EdgeInsets.all(3).w,
                            child: Text(
                              "10% Discount",
                              style: getStyle(10.sp, FontWeight.bold, ColorManager.white),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 45.w,
                                decoration: BoxDecoration(
                                    color: ColorManager.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(10).w)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: ColorManager.green,
                                      size: 15.w,
                                    ),
                                    Text(
                                      "4.5",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.child('pname').value.toString(),
                              style: getStyle(20.sp, FontWeightManager.bold,
                                  ColorManager.redAccent),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              snapshot.child('desc').value.toString(),
                              style: getStyle(13.sp, FontWeightManager.medium,
                                  ColorManager.redAccent),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 0.0, top: 20.0),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorManager.lightGreen,
                                ),
                                child: Row(
                                  children: [
                                    //it's use for decrement the product quantity
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                       _increaseDecreaseProductQuantity(snapshot, false);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        size: 20.h,
                                        color: ColorManager.darkGreen,
                                      ),
                                    ),

                                    //it's show total quantity
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: StreamBuilder(
                                        stream: _listController.getProductQuantity(
                                                productId: snapshot.child('pid').value.toString(), wishlistId: widget.wishId.toString()),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return const Text('Loading...');
                                          }
                                          final quantity = snapshot.data!;
                                          return Text('$quantity');
                                        },
                                      ),
                                    ),

                                    //it's use for Increment the product quantity
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _increaseDecreaseProductQuantity(snapshot,true);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: ColorManager.darkGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1  KG",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              '₹${snapshot.child('prize').value.toString()} ',
                              style: getStyle(
                                  15.sp,
                                  FontWeightManager.superBold,
                                  ColorManager.green),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

//this function is used for increase or decrease product quantity
  _increaseDecreaseProductQuantity(DataSnapshot snapshot,bool val){
    _listController
        .increaseDecreaseProductQuantity(
        productId: snapshot
            .child('pid')
            .value
            .toString(),
        wishlistId:
        widget.wishId.toString(),
        price: snapshot
            .child('prize')
            .value as int,
        isIncrease: val,
        onError: (error) {
          print(error);
        },
        onSuccess: (quntity) {
          print(
              'Incement quantity:$quntity');
        });
  }
}
