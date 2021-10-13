import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/ui_elements/product_card.dart';
import 'package:active_ecommerce_flutter/repositories/product_repository.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class SellerProducts extends StatefulWidget {

  SellerProducts({Key key,this.id, this.shop_name}) : super(key: key);
  final int  id;
  final String  shop_name;

  @override
  _SellerProductsState createState() => _SellerProductsState();
}

class _SellerProductsState extends State<SellerProducts> {

  ScrollController _scrollController = ScrollController();
  ScrollController _xcrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();

  List<dynamic> _productList = [];
  bool _isInitial = true;
  int _page = 1;
  String _searchKey = "";
  int _totalData = 0;
  bool _showLoadingContainer = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();

    _xcrollController.addListener(() {
      //print("position: " + _xcrollController.position.pixels.toString());
      //print("max: " + _xcrollController.position.maxScrollExtent.toString());

      if (_xcrollController.position.pixels ==
          _xcrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
        _showLoadingContainer = true;
        fetchData();

      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _xcrollController.dispose();
    super.dispose();
  }

  fetchData() async {
    var productResponse = await ProductRepository().getShopProducts(id:widget.id,page: _page, name: _searchKey);
    _productList.addAll(productResponse.products);
    _isInitial = false;
    _totalData = productResponse.meta.total;
    _showLoadingContainer = false;
    setState(() {});
  }

  reset() {
    _productList.clear();
    _isInitial = true;
    _totalData = 0;
    _page = 1;
    _showLoadingContainer = false;
    setState(() {});
  }

  Future<void> _onRefresh() async{
    reset();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          buildProductList(),
          Align(
              alignment: Alignment.bottomCenter,
              child: buildLoadingContainer())
        ],
      )
    );
  }

  Container buildLoadingContainer() {
    return Container(
      height: _showLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(_totalData == _productList.length
            ? "No More Products"
            : "Loading More Products ..."),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Container(
        width: 250,
        child: TextField(
          controller: _searchController,
          onTap: () {},
          onChanged: (txt){
            /*_searchKey = txt;
              reset();
              fetchData();*/
          },
          onSubmitted: (txt){
            _searchKey = txt;
            reset();
            fetchData();
          },
          autofocus: true,
          decoration: InputDecoration(
              hintText: "Search products of shop : ".tr()  + widget.shop_name,
              hintStyle: TextStyle(
                  fontSize: 14.0, color: MyTheme.textfield_grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyTheme.white, width: 0.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyTheme.white, width: 0.0),
              ),
              contentPadding: EdgeInsets.all(0.0)),
        )),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: IconButton(
            icon: Icon(Icons.search, color: MyTheme.dark_grey),
            onPressed: () {
              _searchKey = _searchController.text.toString();
              setState(() {

              });
              reset();
              fetchData();
            },
          ),
        ),
      ],
    );
  }

   buildProductList() {
     if (_isInitial && _productList.length == 0) {
       return SingleChildScrollView(
           child: ShimmerHelper()
               .buildProductGridShimmer(scontroller: _scrollController));
     }else if(_productList.length > 0){
       return RefreshIndicator(
         color: MyTheme.accent_color,
         backgroundColor: Colors.white,
         displacement: 0,
         onRefresh: _onRefresh,
         child: SingleChildScrollView(
           controller: _xcrollController,
           physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
           child: GridView.builder(
             // 2
             //addAutomaticKeepAlives: true,
             itemCount: _productList.length,
             controller: _scrollController,
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 crossAxisSpacing: 10,
                 mainAxisSpacing: 10,
                 childAspectRatio: 0.618),
             padding: EdgeInsets.all(16),
             physics: NeverScrollableScrollPhysics(),
             shrinkWrap: true,
             itemBuilder: (context, index) {
               // 3
               return ProductCard(
                 id: _productList[index].id,
                 image: _productList[index].thumbnail_image,
                 name: _productList[index].name,
                 main_price: _productList[index].main_price,
                 stroked_price: _productList[index].stroked_price,
                 has_discount: _productList[index].has_discount,
               );
             },
           ),
         ),
       );
     }else if (_totalData == 0) {
       return Center(child: Text("No data is available".tr()));
     } else {
       return Container(); // should never be happening
     }

  }

}
