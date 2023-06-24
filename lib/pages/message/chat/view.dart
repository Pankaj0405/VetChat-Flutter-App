import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetcurekartchat/common/values/colors.dart';
import 'package:vetcurekartchat/pages/message/chat/index.dart';


class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

AppBar _buildAppBar(){
  return AppBar(
    title: Obx((){
      return Container(
      child: Text(
      "${controller.state.to_name}",
        overflow: TextOverflow.clip,
        maxLines: 1,
        style: TextStyle(
          fontFamily: "Avenir",
          fontWeight: FontWeight.bold,
          color: AppColors.primaryText,
          fontSize: 16.sp
        ),


      ),

      );
  },
   ),
    actions: [
      Container(
        margin: EdgeInsets.only(right: 20.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              child: CachedNetworkImage(
                imageUrl: controller.state.to_avatar.value,
                imageBuilder: (context,imageProvider)=>Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.w),
                    image: DecorationImage(
                      image: imageProvider
                    )
                  ),
                ),
                errorWidget: (context,url,error)=>Image(image:
                AssetImage("assets/images/account_header.png")),
              ),
            ),
            Positioned(
                bottom: 5.w,
                height: 14.w,
                right: 0.w,
                child: Container(

              width: 14.w,
              height: 14.w,
              decoration: BoxDecoration(
                color: controller.state.to_online.value=="1"?AppColors.primaryElementStatus:
                  AppColors.primarySecondaryElementText,
                borderRadius: BorderRadius.circular(12.w),
                border: Border.all(width: 2, color: AppColors.primaryElementText)
              ),
            ))

          ],
        ),
      ),
    ],

  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     appBar: _buildAppBar(),
      body: Obx(()=>SafeArea(
        child: Stack(
          children: [

            Positioned(
              bottom: 0.h,
              child: Container(
                  width: 360.w,
                  padding: EdgeInsets.only(left: 20.w,bottom: 10.h,right: 20.w),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10.h,bottom: 10.h),
                        width: 270.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.w),
                            color: AppColors.primaryBackground,
                            border: Border.all(color: AppColors.primarySecondaryElementText)

                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 220.w,
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                autofocus: false,
                                decoration: InputDecoration(
                                    hintText: "Messages....",
                                    contentPadding: EdgeInsets.only(left: 15.w,top: 0,bottom: 0),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent
                                      ),

                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent
                                      ),

                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent
                                      ),
                                    ),
                                    hintStyle: const TextStyle(
                                      color: AppColors.primarySecondaryElementText,
                                    )
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                child: Image.asset("assets/icons/send.png"),
                              ),
                              onTap: (){

                              },
                            )

                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          height: 40.w,
                          width: 40.w,
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                              color: AppColors.primaryElement,
                              borderRadius: BorderRadius.circular(40.w),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(1,1)
                                )
                              ]
                          ),
                          child: Image.asset("assets/icons/add.png"),
                        ),
                        onTap: (){
                          controller.goMore();
                        },
                      ),

                    ],
                  )
              ),
            ),
            controller.state.more_status.value?Positioned(
                right: 20.w,
                bottom: 70.h,
                height: 200.h,
                width: 40.w,

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 40.h,
                        width: 40.h,
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.h),
                            color: AppColors.primaryBackground,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(1,1)
                              )
                            ]
                        ),
                        child: Image.asset("assets/icons/file.png"),
                      ),
                      onTap: (){

                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 40.h,
                        width: 40.h,
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.h),
                            color: AppColors.primaryBackground,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(1,1)
                              )
                            ]
                        ),
                        child: Image.asset("assets/icons/photo.png"),
                      ),
                      onTap: (){

                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 40.h,
                        width: 40.h,
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.h),
                            color: AppColors.primaryBackground,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(1,1)
                              )
                            ]
                        ),
                        child: Image.asset("assets/icons/call.png"),
                      ),
                      onTap: (){
                        controller.audioCall();


                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 40.h,
                        width: 40.h,
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.h),
                            color: AppColors.primaryBackground,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(1,1)
                              )
                            ]
                        ),
                        child: Image.asset("assets/icons/video.png"),
                      ),
                      onTap: (){

                      },
                    )

                  ],
                ) ):Container()

          ],
        ),


      ),),
    );
  }
}
