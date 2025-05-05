// import 'package:flutter/material.dart';

// class PaginatedDropdown extends StatefulWidget {
//   final Future<List<PaginationDropDownMenuModel>> Function(int page)? fetchItems;
//   final List<PaginationDropDownMenuModel>? items;
//   final Widget Function(PaginationDropDownMenuModel item) itemBuilder;
//   final Widget Function(PaginationDropDownMenuModel item)? selectedItemBuilder;
//   final void Function(PaginationDropDownMenuModel item) onItemSelected;
//   final String hintText;
//   final double dropdownHeight;
//   final EdgeInsetsGeometry? padding;
//   final bool showLoadingIndicator;
//   final Widget? loadingIndicator;
//   final String? noItemsText;
//   final String? errorText;
//   final bool showSearchBar;
//   final TextEditingController? searchController;
//   final Future<List<PaginationDropDownMenuModel>> Function(String query, int page)? onSearch;

//   const PaginatedDropdown({
//     Key? key,
//     this.fetchItems,
//     this.items,
//     required this.itemBuilder,
//     this.selectedItemBuilder,
//     required this.onItemSelected,
//     this.hintText = 'Select an item',
//     this.dropdownHeight = 250.0,
//     this.padding,
//     this.showLoadingIndicator = true,
//     this.loadingIndicator,
//     this.noItemsText = 'No items available',
//     this.errorText = 'Failed to load items',
//     this.showSearchBar = false,
//     this.searchController,
//     this.onSearch,
//   })  : assert(fetchItems != null || items != null, 'Either fetchItems or items must be provided'),
//         assert(showSearchBar == false || onSearch != null, 'onSearch must be provided when showSearchBar is true'),
//         super(key: key);

//   @override
//   _PaginatedDropdownState createState() => _PaginatedDropdownState();
// }

// class _PaginatedDropdownState extends State<PaginatedDropdown> {
//   final LayerLink _layerLink = LayerLink();
//   OverlayEntry? _overlayEntry;
//   final ScrollController _scrollController = ScrollController();
//   final List<PaginationDropDownMenuModel> _items = [];
//   final List<PaginationDropDownMenuModel> _filteredItems = [];
//   bool _isLoading = false;
//   bool _isError = false;
//   int _page = 1;
//   bool _hasMore = true;
//   PaginationDropDownMenuModel? _selectedItem;
//   late TextEditingController _searchController;
//   String _searchQuery = '';
//   bool _isSearching = false;

//   @override
//   void initState() {
//     super.initState();
//     _searchController = widget.searchController ?? TextEditingController();
//     _scrollController.addListener(_scrollListener);
//   }

//   @override
//   void didUpdateWidget(covariant PaginatedDropdown oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.items != oldWidget.items && widget.items != null) {
//       _items.clear();
//       _items.addAll(widget.items!);
//       _filterItems();
//     }
//   }

//   void _scrollListener() {
//     if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
//       _loadMore();
//     }
//   }

//   void _loadInitialItems() {
//     if (widget.items != null) {
//       _items.clear();
//       _items.addAll(widget.items!);
//       _filterItems();
//     } else if (widget.fetchItems != null && !_isSearching) {
//       _loadMore();
//     }
//   }

//   void _loadMore() async {
//     if (_isLoading || !_hasMore) return;

//     setState(() {
//       _isLoading = true;
//       _isError = false;
//     });

//     try {
//       List<PaginationDropDownMenuModel> newItems;

//       if (_isSearching && widget.onSearch != null) {
//         newItems = await widget.onSearch!(_searchQuery, _page) ?? [];
//       } else if (widget.fetchItems != null) {
//         newItems = await widget.fetchItems!(_page) ?? [];
//       } else {
//         newItems = [];
//       }

//       setState(() {
//         _items.addAll(newItems);
//         _filterItems();
//         _isLoading = false;
//         _hasMore = newItems.isNotEmpty;
//         if (_hasMore) _page++;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _isError = true;
//       });
//       debugPrint('Failed to load items: $e');
//     }
//   }

//   void _filterItems() {
//     if (_searchQuery.isEmpty) {
//       _filteredItems.clear();
//       _filteredItems.addAll(_items);
//     } else {
//       _filteredItems.clear();
//       _filteredItems.addAll(_items.where((item) => item.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false));
//     }
//     setState(() {});
//   }

//   void _onSearchChanged(String query) {
//     _searchQuery = query;
//     _isSearching = query.isNotEmpty;
//     _page = 1;
//     _items.clear();
//     _filterItems();
//     _loadMore();
//   }

//   void _toggleDropdown() {
//     if (_overlayEntry == null) {
//       _overlayEntry = _buildOverlay();
//       Overlay.of(context).insert(_overlayEntry!);
//       _loadInitialItems();
//     } else {
//       _overlayEntry?.remove();
//       _overlayEntry = null;
//     }
//   }

//   OverlayEntry _buildOverlay() {
//     final renderBox = context.findRenderObject() as RenderBox?;
//     final size = renderBox?.size ?? Size.zero;

//     return OverlayEntry(
//       builder: (context) => Positioned(
//         width: size.width,
//         child: CompositedTransformFollower(
//           link: _layerLink,
//           showWhenUnlinked: false,
//           offset: Offset(0.0, size.height + 5.0),
//           child: Material(
//             elevation: 8.0,
//             borderRadius: BorderRadius.circular(4.0),
//             child: SizedBox(
//               // height: widget.dropdownHeight,
//               child: Column(
//                 children: [
//                   if (widget.showSearchBar) ...[
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextField(
//                         controller: _searchController,
//                         decoration: InputDecoration(
//                           hintText: 'Search...',
//                           prefixIcon: Icon(Icons.search),
//                           border: OutlineInputBorder(),
//                           contentPadding: EdgeInsets.symmetric(vertical: 10),
//                         ),
//                         onChanged: _onSearchChanged,
//                       ),
//                     ),
//                     Divider(height: 1),
//                   ],
//                   Expanded(
//                     child: _buildContent(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContent() {
//     if (_isError) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Text(widget.errorText!),
//         ),
//       );
//     }

//     if (_filteredItems.isEmpty && !_isLoading) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Text(widget.noItemsText!),
//         ),
//       );
//     }

//     return ListView.builder(
//       controller: _scrollController,
//       // padding: widget.padding,
//       shrinkWrap: true,
//       itemCount: _filteredItems.length + (_isLoading && widget.showLoadingIndicator ? 1 : 0),
//       itemBuilder: (context, index) {
//         if (index >= _filteredItems.length) {
//           return widget.loadingIndicator ??
//               const Center(
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//         }

//         final item = _filteredItems[index];
//         return InkWell(
//           onTap: () {
//             setState(() {
//               _selectedItem = item;
//               widget.onItemSelected(item);
//             });
//             _toggleDropdown();
//           },
//           child: widget.itemBuilder(item),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _overlayEntry?.remove();
//     _scrollController.dispose();
//     if (widget.searchController == null) {
//       _searchController.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: GestureDetector(
//         onTap: _toggleDropdown,
//         child: InputDecorator(
//           decoration: InputDecoration(
//             labelText: widget.hintText,
//             suffixIcon: const Icon(Icons.arrow_drop_down),
//             border: const OutlineInputBorder(),
//           ),
//           child: widget.selectedItemBuilder != null && _selectedItem != null
//               ? widget.selectedItemBuilder!(_selectedItem!)
//               : Text(
//                   _selectedItem?.name ?? '',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//         ),
//       ),
//     );
//   }
// }
