import 'package:driver/Screens/profile.dart';
import 'package:driver/Screens/slider.dart';
import 'package:driver/Widgets/ExpandedListAnimationWidget.dart';
import 'package:driver/Widgets/Scrollbar.dart';
import 'package:driver/Widgets/orderDetail_Items.dart';
import 'package:flutter/material.dart';

///
/// order detail class
///
class OrderDetail extends StatefulWidget {
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  bool isStrechedDropDown = false;
  bool isStrechedDropDown1 = false;
  String title = 'قيد الانتظار';
  List<String> _categoryName = ["تم التوصيل"];
  var img = 'assets/order_status_indicator.png';
  List _categoryImages = [
    'assets/order_status_indicator.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffold,

        ///
        /// drawer or slider
        ///
        endDrawer: DrawerSlider(),

        ///
        /// app bar
        ///
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(65.0),
            child: AppBar(
              backgroundColor: Color(0xffEF4A8E),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),

              ///
              /// search icon
              ///
              leading: Image.asset('assets/search_ic.png'),
              centerTitle: true,

              ///
              /// home logo
              ///
              title: Image.asset('assets/logo_home.png'),

              ///
              /// back icon
              ///
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Image.asset('assets/chevron-right.png')))
              ],
              // ...
            )),
        backgroundColor: Color(0xffEFF2F3),

        ///
        /// body
        ///
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                color: Color(0xffEFF2F3),
                height: MediaQuery.of(context).size.height * 0.27,
                child: ListView.builder(
                  ///
                  /// number of items
                  ///
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    ///
                    /// call order detail items
                    ///
                    return OrderDetailItems();
                  },
                ),
              ),

              ///
              /// customer detail or تفاصيل العميل container
              ///
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14),
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'تفاصيل العميل',
                      style: TextStyle(
                          color: Color(0xff8D8D8D), fontFamily: 'MEDIUM'),
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17)),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17)),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 14, right: 14, bottom: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ///
                            /// date text
                            ///
                            Text(
                              'Aug 7, 2021',
                              style: TextStyle(color: Colors.black),
                            ),

                            ///
                            /// abdullah or عبدالله
                            ///
                            Text(
                              'عبدالله',
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'MEDIUM'),
                            ),
                          ],
                        ),
                      ),

                      ///
                      ///  نقد عند التسليم container or cash on delivery
                      ///
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ///
                            /// cash on delivery  or  نقد عند التسليم text
                            ///
                            Text(
                              'نقد عند التسليم',
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'MEDIUM'),
                            )
                          ],
                        ),
                      ),

                      ///
                      /// الرياض السعودية or location container
                      ///
                      Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 2, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'الرياض السعودية',
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'MEDIUM'),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xff8D8D8D),
                      ),

                      ///
                      /// المبلغ الإجمالي 514 or total amount container
                      ///
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),

                                ///
                                /// total amount
                                ///
                                Text(
                                  '514.00',
                                  style: TextStyle(
                                      color: Color(0xffEF4A8E),
                                      fontFamily: 'MEDIUM'),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                ///
                                /// total amount text
                                ///
                                Text(
                                  'المبلغ الإجمالي',
                                  style: TextStyle(
                                      color: Color(0xff8D8D8D),
                                      fontFamily: 'MEDIUM'),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ///
              /// custom drop down
              ///
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 13),
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              right: 15, left: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          constraints: BoxConstraints(
                            minHeight: 45,
                            minWidth: double.infinity,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isStrechedDropDown = !isStrechedDropDown;
                                    });
                                  },
                                  child: Icon(Icons.keyboard_arrow_down)),
                              Row(
                                children: [
                                  Text(title,
                                      style: TextStyle(
                                          fontFamily: 'MEDIUM', fontSize: 15)),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Image.asset(
                                    img.toString(),
                                    height: 35,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 13),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: ExpandedSection(
                              expand: isStrechedDropDown,
                              height: 100,
                              child: MyScrollbar(
                                builder: (context, scrollController2) =>
                                    ListView.builder(
                                        padding: EdgeInsets.all(0),
                                        controller: scrollController2,
                                        shrinkWrap: true,
                                        itemCount: _categoryName.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                              leading: Image.asset(
                                                  _categoryImages
                                                      .elementAt(index)),
                                              title: Text(_categoryName
                                                  .elementAt(index)),
                                              onTap: () {
                                                // isVisible = !isVisible;
                                                isStrechedDropDown =
                                                    !isStrechedDropDown;
                                                setState(() {
                                                  title = _categoryName
                                                      .elementAt(index);
                                                  img = _categoryImages
                                                      .elementAt(index);
                                                  print(img);
                                                });
                                              });
                                        }),
                              ),
                            ))
                      ],
                    )),
                  ],
                ),
              ),

              ///
              /// تفاصيل المسؤول or Administrator details text
              ///
              Container(
                padding: EdgeInsets.only(right: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('تفاصيل المسؤول',
                        style: TextStyle(
                            color: Color(
                              0xff8D8D8D,
                            ),
                            fontFamily: 'MEDIUM')),
                  ],
                ),
              ),

              ///
              /// Administrator details container
              ///
              Container(
                margin:
                    EdgeInsets.only(left: 13, right: 13, top: 10, bottom: 150),
                padding: EdgeInsets.only(top: 5, bottom: 23),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 7,
                                  child: Container(
                                      child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ///
                                          /// user name text like usman ali عثمان على text
                                          ///
                                          Text(
                                            'عثمان على',
                                            textAlign: TextAlign.right,
                                            style:
                                                TextStyle(fontFamily: 'MEDIUM'),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),

                                      ///
                                      /// user location
                                      ///
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text('الرياض السعودية',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontFamily: 'MEDIUM',
                                                  color: Color(0xff8D8D8D)))
                                        ],
                                      ),
                                    ],
                                  ))),

                              ///
                              /// admin image
                              ///
                              Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap:(){
                                      ///
                                      /// navigate to profile screen
                                      /// 
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
                                    },
                                    child: Container(
                                        child:
                                            Image.asset('assets/admin_dp.png')),
                                  )),
                            ],
                          ),

                          ///
                          /// whatApp number container
                          ///
                          Container(
                              margin: EdgeInsets.only(top: 15),
                              width: MediaQuery.of(context).size.width * 0.47,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xff00E676))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ///
                                  /// whatApp image
                                  ///
                                  Image.asset('assets/whatsapp_ic.png'),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),

                                  ///
                                  /// whatApp number
                                  ///
                                  Text('+966 59 1234567',
                                      style: TextStyle(
                                          color: Color(0xff00E676),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15)),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        ///
        /// bottom sheet
        ///
        bottomSheet: Container(
          color: Color(0xffEFF2F3),
          child: ClipRRect(
            ///
            /// top rounded sheet
            ///
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///
                    /// confirm or تاكيد container
                    ///
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      padding: EdgeInsets.only(
                          top: 9, bottom: 12, left: 41, right: 41),
                      decoration: BoxDecoration(

                          ///
                          /// pink color
                          ///
                          color: Color(0xffEF4A8E),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'تاكيد',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'MEDIUM',
                            fontSize: 15),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
