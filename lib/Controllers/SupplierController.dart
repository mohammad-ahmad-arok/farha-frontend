import 'package:get/get.dart';
import '../Api/supplierApi.dart';
import '../Models/SupplierModel.dart';


class SupplierController extends GetxController {
  var suppliers = <Supplier>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchSuppliers();
    super.onInit();
  }

  Future<void> fetchSuppliers() async {
    try {
      isLoading(true);
      errorMessage('');
      var fetchedSuppliers = await SupplierApi.getSuppliers();
      suppliers.assignAll(fetchedSuppliers);
    } catch (e) {
      errorMessage('حدث خطأ: $e');
    } finally {
      isLoading(false);
    }
  }
}