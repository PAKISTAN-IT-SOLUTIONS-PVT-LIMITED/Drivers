
import 'package:driver/Screens/orderDetail.dart';
import 'package:flutter/material.dart';

///
/// order item class
/// 
class OrderItems extends StatefulWidget {
  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: InkWell(
        onTap: (){

          ///
          /// navigate to orderDetail class
          /// 
          Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderDetail()));
        },
        ///
        /// card
        /// 
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                     ///
                                     /// yellow circle 
                                     /// 
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Color(0xffDDB860),
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.01,
                                    ),
                                    ///
                                    /// pending text or قيد الانتظار
                                    Text(
                                      'قيد الانتظار',
                                      style: TextStyle(
                                          color: Color(0xff8D8D8D),
                                          fontFamily: 'MEDIUM', fontSize: 13),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    ///
                                    /// abdullah or عبدالله
                                    /// 
                                    Text(
                                      'عبدالله',
                                      textAlign: TextAlign.right,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: 'BOLD'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ///
                                  ///my orders or الطلباتي
                                  ///
                                  Text(
                                    'الطلباتي',
                                    style: TextStyle(color: Color(0xffDDB860), fontFamily: 'MEDIUM', fontSize: 13),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.02,
                                  ),
                                  ///
                                  /// number of orders
                                  /// 
                                  Text(
                                    '2',
                                    style: TextStyle(color: Color(0xffDDB860), fontFamily: 'MEDIUM'),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  ///
                                  /// date of orders
                                  /// 
                                  Text(
                                    'Aug 7, 2021',
                                    style: TextStyle(
                                        color: Color(0xff8D8D8D),
                                        fontFamily: 'MEDIUM'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                ///
                /// rounded image 
                /// 
                Expanded(
                  flex: 2,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      ///
                      /// image
                      /// 

                      child: Image.asset('assets/order_placer_dp1.png')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
