import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/pagination_drop_down_menu.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';

class PaginatedDropdownExample extends StatefulWidget {
  final TextEditingController searchController;
  final Function(PaginationDropDownMenuModel)? onItemSelected;

  const PaginatedDropdownExample({super.key, required this.searchController, this.onItemSelected});

  @override
  _PaginatedDropdownExampleState createState() => _PaginatedDropdownExampleState();
}

class _PaginatedDropdownExampleState extends State<PaginatedDropdownExample> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  OverlayEntry? _overlayEntry;
  List<PaginationDropDownMenuModel> items = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading && hasMore) {
        currentPage++;
        fetchItems(currentPage);
      }
    });
  }

  void _toggleDropdown() async {
    if (_overlayEntry == null) {
      items.clear();
      currentPage = 1;
      hasMore = true;

      await fetchItems(currentPage); // Wait until data is fetched
      if (items.isNotEmpty) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry!);
      }
    } else {
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Future<void> fetchItems(int page) async {
    setState(() => isLoading = true);

    try {
      var dioHelper = DioImpl();
      Response res = await dioHelper.get(endPoint: '${EndPoints.allBranches}?page=$page');

      List<PaginationDropDownMenuModel> fetchedItems = (res.data['content'] as List).map((item) => PaginationDropDownMenuModel.fromJson(item)).toList();

      setState(() {
        if (fetchedItems.isEmpty) {
          hasMore = false;
        } else {
          items.addAll(fetchedItems);
        }
      });
    } catch (e) {
      print('Error fetching items: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = _fieldKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        left: offset.dx,
        top: offset.dy + size.height + 5,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            color: Colors.white,
            elevation: 4,
            child: SizedBox(
              height: 200,
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(0.0),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  print('Selected: ${items[index].name}');
                                  _removeOverlay();
                                  widget.onItemSelected?.call(items[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    items[index].name ?? '',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CompositedTransformTarget(
        link: _layerLink,
        child: GestureDetector(
          onTap: _toggleDropdown,
          child: CustomTextFormField(
            controller: widget.searchController,
            key: _fieldKey,
            hintText: 'Cashier Name',
            enabled: false,
            readOnly: true,
            title: 'Cashier Name',
          ),
        ),
      ),
    );
  }
}

class PaginationDropDownMenuModel {
  final String? name;
  final int? id;

  PaginationDropDownMenuModel({this.name, this.id});

  @override
  String toString() {
    return name ?? '';
  }

  factory PaginationDropDownMenuModel.fromJson(Map<String, dynamic> json) {
    return PaginationDropDownMenuModel(
      name: json['name'] as String?,
      id: json['id'] as int?,
    );
  }
}
