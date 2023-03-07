
import '../screenbarrel/screen_barrel.dart';

class ConstSnackbar{

  successSnackbar()=>Get.snackbar('Success', 'Successfully Login',backgroundColor: Colors.green,snackPosition: SnackPosition.BOTTOM);
  resetSuccessSnackbar()=>Get.snackbar('Success', 'Successfully send Resetpassword Email',backgroundColor: Colors.green,snackPosition: SnackPosition.BOTTOM);
  failedSnackbar(String error)=>Get.snackbar('Not Valid', error.toString(),backgroundColor: Colors.red,snackPosition: SnackPosition.BOTTOM);
}