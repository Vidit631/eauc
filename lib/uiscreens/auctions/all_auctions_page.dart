import 'package:auto_size_text/auto_size_text.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/uiscreens/advanced_filter.dart';
import 'package:eauc/widgetmodels/customtextbutton.dart';
import 'package:eauc/widgetmodels/header_row.dart';
import 'package:eauc/widgetmodels/see_all_button.dart';
import 'package:flutter/material.dart';

import 'auctions_page_container.dart';

class AllAuctionsPage extends StatefulWidget {
  const AllAuctionsPage({Key? key}) : super(key: key);

  @override
  _AllAuctionsPageState createState() => _AllAuctionsPageState();
}

class _AllAuctionsPageState extends State<AllAuctionsPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 10,
              child: TextFormField(
                cursorColor: kprimarycolor,
                style: kSearchFieldTextStyle,
                decoration: kSearchFieldDecoration.copyWith(
                  hintText: 'Search in All Auctions',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      //TODO: Clear the search field
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                ),
                onChanged: (value) {
                  //TODO: Build search list
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                splashRadius: 1,
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: kprimarycolor,
                ),
                onPressed: () {
                  //TODO: Pop Up Menu
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AdvancedFilter(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        );
                      });
                },
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeaderRow(
                    headerText: 'Ongoing Auctions',
                    onTap: () {
                      //TODO: Navigate to All Ongoing Auctions Page perhaps
                    }),
                Container(
                  height: kAuctionsListViewHeight,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return AuctionsPageContainer(
                          productName: 'Product1',
                          hostName: 'HostName',
                          currentBid: '5000',
                          type: 'Live',
                          imageName: 'sampleimage1',
                          time: '13/12/2022 13:23',
                        );
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
                HeaderRow(
                    headerText: 'Upcoming Auctions',
                    onTap: () {
                      //TODO: Navigate to All Ongoing Auctions Page perhaps
                    }),
                Container(
                  height: kAuctionsListViewHeight,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return AuctionsPageContainer(
                        productName: 'Product1',
                        hostName: 'HostName',
                        currentBid: '5000',
                        type: 'Upcoming',
                        imageName: 'sampleimage1',
                        time: '13/12/2022 13:23',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}