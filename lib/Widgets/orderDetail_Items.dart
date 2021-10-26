import 'package:flutter/material.dart';

class OrderDetailItems extends StatefulWidget {
  @override
  _OrderDetailItemsState createState() => _OrderDetailItemsState();
}

class _OrderDetailItemsState extends State<OrderDetailItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'ساعة نسائية صناعة سويسرية موديل',
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                          
                              fontFamily: 'MEDIUM'),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'قطع',
                                  style: TextStyle(color: Color(0xffDDB860), fontFamily: 'MEDIUM', fontSize: 13),
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(color: Color(0xffDDB860), fontFamily: 'MEDIUM'),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                          children: [
                            Text(
                              'ريال',
                              style: TextStyle(
                                  color: Color(0xffEF4A8E),
                                  fontFamily: 'MEDIUM'),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.005,
                            ),
                            Text(
                              '100.00',
                              style: TextStyle(
                                  color: Color(0xffEF4A8E),
                                  fontFamily: 'MEDIUM'),
                            ),
                          ],
                        ),
                      
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Expanded(
                flex: 2,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Image.asset('assets/product_thum1.png')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
