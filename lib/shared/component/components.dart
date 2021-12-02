// import 'package:flutter/material.dart';
// import 'package:tadoo_app/shared/cubit_todo/cubit.dart';

import 'package:chat_app/shared/style/color.dart';
import 'package:chat_app/shared/style/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:news_app/moduls/web_view/web_view.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultAppBar(
        {@required BuildContext context, String title, List<Widget> actions}) =>
    AppBar(
        title: Text(title),
        actions: actions,
        titleSpacing: 05.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(IconBroken.Arrow___Left_2)));

Widget defaultTextButton({@required Function fct, @required String label}) {
  return TextButton(
      onPressed: () {
        fct();
      },
      child: Text(label.toUpperCase()));
}
// //
// // Widget defaultFormField(
// //     // IconData suffix,
// //     //      Function onSubmit,
// //     //     Function onChange,
// //         {
// //       Function? onSubmit,
// //       required TextEditingController controller,
// //       required TextInputType type,
// //
// //       bool isPassword = false,
// //       required Function validate,
// //       required String label,
// //       required IconData prefix,
// //
// //       required Function suffixPressed,
// //     }) => TextFormField(
// //   controller: controller,
// //   keyboardType: type,
// //   onEditingComplete:()=> onSubmit,
// //   // obscureText: isPassword,
// //   // onFieldSubmitted: onSubmit(),
// //   // onChanged: onChange(),
// //   validator: validate(),
// //   decoration: InputDecoration(
// //     labelText: label,
// //     prefixIcon: Icon(
// //       prefix,
// //     ),
// //     // suffixIcon: suffix != null ? IconButton(
// //     //   onPressed:()=> suffixPressed,
// //     //   icon: Icon(
// //     //     suffix,
// //     //   ),
// //     // ) : null,
// //     border: OutlineInputBorder(),
// //   ),
// // );
// // Widget defaultFormField2(
// //     // IconData suffix,
// //     //      Function onSubmit,
// //     //     Function onChange,
// //         {
// //       required TextEditingController controller,
// //       required TextInputType type,
// //
// //       bool isPassword = false,
// //       required Function validate,
// //       required String label,
// //       required IconData prefix,
// //
// //       required Function suffixPressed,
// //     }) => TextFormField(
// //   controller: controller,
// //   keyboardType: type,
// //   obscureText: isPassword,
// //   // onFieldSubmitted: onSubmit(),
// //   // onChanged: onChange(),
// //   validator: validate(),
// //   decoration: InputDecoration(
// //     labelText: label,
// //     prefixIcon: Icon(
// //       prefix,
// //     ),
// //     // suffixIcon: suffix != null ? IconButton(
// //     //   onPressed:()=> suffixPressed,
// //     //   icon: Icon(
// //     //     suffix,
// //     //   ),
// //     // ) : null,
// //     border: OutlineInputBorder(),
// //   ),
// // );

Widget defaultFormField( //   Null Function() onChange,
    //   Null Function() onSubmit,

    {
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onTap,
  // Function? onChange,
  IconData suffix,
  Function suffixPressed,
  bool isPassword = false,
  bool isClicked = true,
  @required Function validate,
  @required String label,
  @required IconData prefix,
}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: TextFormField(
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (s) {
        onSubmit(s);
      },
      // onChanged: (s) {
      //   onChange!(s);
      // },
      validator: validate,
      enabled: isClicked,
      decoration: InputDecoration(
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed();
                  },
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
          labelText: label,
          prefixIcon: Icon(prefix),
          border: const OutlineInputBorder()),
    ),
  );
}

// Widget buildListProduct(model, context,{bool isOldPrice=true}) {
//   return  Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Container(
//       height: 120,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             alignment: AlignmentDirectional.bottomStart,
//             children: [
//               Image(
//                 image: NetworkImage(model.image),
//                 width: 120,
//                 height: 120.0,
//               ),
//               if (model.discount != 0&&isOldPrice)
//                 Container(
//                   color: Colors.red,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 5.0,
//                   ),
//                   child: const Text(
//                     'DISCOUNT',
//                     style: TextStyle(
//                       fontSize: 8.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   model.name,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 14.0,
//                     height: 1.3,
//                   ),
//                 ),
//                 Spacer(),
//                 Row(
//                   children: [
//                     Text(
//                       model.price.toString(),
//                       style: const TextStyle(
//                         fontSize: 12.0,
//                         color: defaultColor,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 5.0,
//                     ),
//                     if (model.discount != 0&&isOldPrice)
//                       Text(
//                         model.oldPrice.toString(),
//                         style: const TextStyle(
//                           fontSize: 10.0,
//                           color: Colors.grey,
//                           decoration: TextDecoration.lineThrough,
//                         ),
//                       ),
//                     Spacer(),
//                     IconButton(
//                       onPressed: () {
//                         ShopCubit.get(context)
//                             .changeFavorites(model.id);
//                         print(model.id);
//                       },
//                       icon: CircleAvatar(
//                         radius: 15.0,
//                         backgroundColor: ShopCubit.get(context)
//                             .favourites[model.id]
//                             ? defaultColor
//                             : Colors.grey,
//                         child: const Icon(
//                           Icons.favorite_border,
//                           size: 14.0,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

void showToast({@required String msg, @required ToastState state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        // webBgColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
enum ToastState { success, warning, error }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.yellow;
      break;
  }
  return color;
}
// Widget taskSFromDatabase(Map model, BuildContext context) => Dismissible(
//       key: UniqueKey(),
//       onDismissed: (direction) {
//         AppCubit.get(context).deleteData(id: model['id']);
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 40,
//               child: Text(
//                 '${model['time']}',
//               ),
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${model['title']}',
//                     style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     '${model['date']}',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             IconButton(
//                 onPressed: () {
//                   AppCubit.get(context).updateData(
//                     status: 'done',
//                     id: model['id'],
//                   );
//                 },
//                 icon: Icon(
//                   Icons.check_box,
//                   color: Colors.green,
//                 )),
//             IconButton(
//                 onPressed: () {
//                   AppCubit.get(context).updateData(
//                     status: 'archive',
//                     id: model['id'],
//                   );
//                 },
//                 icon: Icon(
//                   Icons.archive_outlined,
//                   color: Colors.black45,
//                 )),
//           ],
//         ),
//       ),
//     );

// Widget buildArticleItems(article, context) => InkWell(
//       onTap: () {
//         navigateTo(
//           context,
//           WebViewScreen(
//             article['url'],
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Container(
//               width: 120,
//               height: 120,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   image: DecorationImage(
//                       image: article['urlToImage'] == null
//                           ? NetworkImage(
//                               'https://m.media-amazon.com/images/I/71JN-6UNnAL.jpg')
//                           : NetworkImage('${article['urlToImage']}'),
//                       fit: BoxFit.cover)),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: Container(
//                 height: 120,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         '${article['title']}',
//                         maxLines: 4,
//                         overflow: TextOverflow.ellipsis,
//                         style: Theme.of(context).textTheme.bodyText1,
//                       ),
//                     ),
//                     Text(
//                       '${article['publishedAt']}',
//                       style: Theme.of(context).textTheme.bodyText2,
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//
// Widget articleBuilder(list, BuildContext context,{isSearch = false}) =>
// BuildCondition(
//       condition: list.length > 0,
//       builder: (context) => ListView.separated(
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (context, index) =>
//             buildArticleItems(list[index], context),
//         separatorBuilder: (context, index) => Padding(
//           padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
//           child: Container(
//             width: double.infinity,
//             height: 1,
//             color: Colors.grey[400],
//           ),
//         ),
//         itemCount: list.length,
//       ),
//       fallback:(context) => isSearch ? Container() :   const Center(child: CircularProgressIndicator()),
//     );
//
navigateTo(context, widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
}

navigateAndReplacement(context, widget) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => widget));
}
