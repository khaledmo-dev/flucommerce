import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/common.dart';
import 'package:flutter/material.dart';

class RefundPolicyScreen extends StatelessWidget {
  const RefundPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ResponsiveText(
          "refund_policy".translate(),
          style: Theme.of(context).textTheme.bodySmall!,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ResponsiveText(
            '''سياسة الاستبدال:
            
            1- يحق للمستهلك (العميل) دون الاخلال بأحكام الضمان والاتفاقية – استبدال او استرجاع المنتج المقدم من المتجر خلال فترة أقصاها سبعة أيام اعتبارا من يوم استلام المنتج , ولا يحق له استبداله بعد هذه الفترة .
            
            2- في حال استبدال او استرجاع المنتج يشترط بأن يكون المنتج بحالة سليمة من أي استخدام او فتح بشكل عشوائي ويحق للمتجر معاينة المنتج قبل استبداله للتأكد من سلامته .
            
            3- يتحمل المستهلك رسوم الشحن في حال طلب استبداله او استرجاع المنتج , وفي الشحن الدولي يتحمل المستهلك كافة تكاليف الشحن وما يترتب عليها من تكاليف أخرى , وفي حال وجود عيوب أو خطأ سيتم تعويض المستهلك .
            
            لا يحق للمستهلك استبدال او استرجاع المنتج في الحالات التالية:
            
            1- في حال صنع المنتج او صمم او طبع او طرز بحسب طلب الزبون وبحسب مواصفات حددها لا يمكن في هذه الحالة استبدال المنتج , الا في حالة وجد فيه خطأ او عيب خالف المواصفات المحددة من قبل المستهلك .
            
            2- لا يمكن استرجاع او استبدال أي منتج  كان عبارة عن أشرطة فيديو أو أسطوانات أو أقراصاً مدمجة أو برامج معلوماتية تم استخدامها.
            
            3- إذا كان المنتج عبارة صحف أو مجلّات أو منشورات أو كتب أو غير ذلك مما يُعَد من المؤلفات.
            
            4- لا يستبدل المنتج في حال ظهر فيه عيب بسبب سوء حيازة المستهلك.
            
            5- إذا كان العقد يتناول شراء منتجات تحميل البرامج عبر الانترنت.
            
            ''',
            style: Theme.of(context).textTheme.bodySmall!,
          ),
        ),
      ),
    );
  }
}
