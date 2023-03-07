import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../screenbarrel/screen_barrel.dart';

class ShoppingList extends StatefulWidget {
  static const id = 'shoppinglists';

  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  String textTitle = 'home';
  String textType = 'private';
  final ListController _listController = ListController();
  TextEditingController wishlistTitleController = TextEditingController();
  TextEditingController wishlistTypeController = TextEditingController();
  TextEditingController wishlistPriceController = TextEditingController();
  TextEditingController wishlistQuantityController = TextEditingController();

  Stream<QuerySnapshot>? _stream; // stram variable
  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instance; // firebase auth instance
  User? get cureentUser => _firebaseAuth.currentUser; //Current user

  @override
  void initState() {
    super.initState();
    _stream = _listController.getWishList();
  }

  //it's use for cleartextfield
  void clearText() {
    wishlistTitleController.clear();
    wishlistTypeController.clear();
  }

//Current user Name
  Widget _personName() {
    return Text(
      cureentUser?.displayName ?? '',
      style: TextStyle(
        color: ColorManager.white,
        fontSize: 10.sp,
      ),
    );
  }

//Current user email
  Widget _personEmail() {
    return Text(
      cureentUser?.email ?? '',
      style: TextStyle(
        color: ColorManager.white,
        fontSize: 18.sp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('WishList'),
        backgroundColor: ColorManager.green,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot getListValue =
                              snapshot.data!.docs[index];
                          final uId = getListValue["user_id"];
                          final wishId = getListValue['id'];

                          return GestureDetector(
                            onTap: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                        uid: uId,
                                        wishId: wishId,
                                      ));
                              Navigator.push(context, route).then(onGoBack);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: ColorManager.white,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8).w),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                              left: 10, top: 10, bottom: 50)
                                          .r,
                                      child: Column(
                                        children: [
                                          Text(
                                            getListValue['title'],
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          Text(
                                            getListValue['priority'],
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 8.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                bottomRight: Radius.circular(8))
                                            .w,
                                        color: Colors.green[50],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                top: 32,
                                                bottom: 32)
                                            .r,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Totals:',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10.sp),
                                                ),
                                                ProductQuantityPriceStreambuilder(
                                                    stream: _listController
                                                        .getTotalQuantityPrice(
                                                            wishlistId:
                                                                getListValue[
                                                                    'id']),
                                                    quantityOrPrice:
                                                        'quantity'),
                                              ],
                                            ),
                                            ProductQuantityPriceStreambuilder(
                                                stream: _listController
                                                    .getTotalQuantityPrice(
                                                        wishlistId:
                                                            getListValue['id']),
                                                quantityOrPrice: 'price'),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 10)
                            .r,
                    child: GestureDetector(
                      onTap: () {
                        wishList();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorManager.lemonGreen,
                          borderRadius: BorderRadius.circular(20).w,
                          border: Border.all(color: ColorManager.green),
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 13, bottom: 13).r,
                              child: Text(
                                'New list',
                                style: TextStyle(
                                  color: ColorManager.fullDarkGreen,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10).r,
                              child: CircleAvatar(
                                backgroundColor: ColorManager.fullDarkGreen,
                                radius: 12.r,
                                child: Icon(
                                  Icons.add,
                                  size: 15.sp,
                                  color: Colors.green[50],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: ColorManager.green,
              ),
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: _personName(),
              accountEmail: _personEmail(),
              decoration: BoxDecoration(
                color: ColorManager.green,
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.account_circle_sharp,
                  size: 50,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.local_drink_sharp),
              title: const Text('Cocktails'),
              onTap: () {
                Get.toNamed(CocktailViewScreen.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                _firebaseAuth.signOut();
                Get.toNamed(LoginScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  wishList() {
    showModalBottomSheet(
        backgroundColor: ColorManager.fullDarkGreen,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(10).w,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30).w,
                  child: const TitleTextWidget(titleText: 'Add item'),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: wishlistTitleController,
                  cursorColor: ColorManager.white,
                  style: TextStyle(color: ColorManager.white.withOpacity(0.9)),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle:
                        TextStyle(color: ColorManager.white.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: ColorManager.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25).w,
                        borderSide:
                            BorderSide(width: 0.w, style: BorderStyle.none)),
                  ),
                  onChanged: (value) {
                    textTitle = value;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: wishlistTypeController,
                  cursorColor: ColorManager.white,
                  style: TextStyle(color: ColorManager.white.withOpacity(0.9)),
                  decoration: InputDecoration(
                    hintText: 'Type',
                    hintStyle:
                        TextStyle(color: ColorManager.white.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: ColorManager.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25).w,
                        borderSide:
                            BorderSide(width: 0.w, style: BorderStyle.none)),
                  ),
                  onChanged: (value) {
                    textType = value;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Spacer(),
                FormSubmitButton(
                  buttonText: 'Submit',
                  onSubmitForm: () => _addNewWishlistButton(),
                ),
              ],
            ),
          );
        });
  }

  _addNewWishlistButton() {
    _listController.addWishlistItem(title: textTitle, priority: textType);
    clearText();
    Navigator.of(context).pop();
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
}
