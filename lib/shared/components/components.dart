// ignore_for_file: avoid_types_as_parameter_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultFromFiled({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  bool isPassword = false,
  void Function(String)? onChanged,
  FormFieldValidator? validator,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  GestureTapCallback? onTap,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validator,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(suffix),
          ),
          border: const OutlineInputBorder()),
    );

Widget buildTaskItem(Map model , context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              '${model['time']}',
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '${model['date']}',
                style: const TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );

Widget buildArticalItem(article, context) {
  return InkWell(
    onTap: () {
      navigateTo(context, WebViewScreen(url: article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: NetworkImage('${article['image']}'),fit: BoxFit.cover)
              ),
              
          ),
          
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text('${article['title']}',
                        maxLines: 3,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget articaleBuilder(list, context , {isSearch = false}) => ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) {
      return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticalItem(list[index], context),
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
                  thickness: 1,
                  color: Color.fromARGB(255, 121, 120, 120),
                ),
          ),
          itemCount: list.length);
    },
    fallback: (context) => isSearch ? Container() : const Center(child: CircularProgressIndicator()));

// ignore: non_constant_identifier_names
void navigateTo(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));
