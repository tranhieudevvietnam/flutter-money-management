import 'package:flutter/material.dart';

typedef BuildDropdownWidget<T> = Widget Function(BuildContext context, T? data);

// ignore: must_be_immutable
class DropdownWidget<T> extends StatefulWidget {
  final BuildDropdownWidget<T> builderDropdownItem;
  final BuildDropdownWidget<T> builderDropdownItemMenu;
  final List<T> listData;
  final Function(T value)? onChange;
  final Function(OverlayEntry overlayEntry)? initOverlayEntry;
  T? data;
  DropdownWidget({
    Key? key,
    required this.listData,
    required this.builderDropdownItem,
    required this.builderDropdownItemMenu,
    this.data,
    this.initOverlayEntry,
    this.onChange,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DropdownWidgetState<T> createState() => _DropdownWidgetState<T>();
}

class _DropdownWidgetState<T> extends State<DropdownWidget<T>> {
  // final FocusNode _focusNode = FocusNode();

  late OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  bool showDropView = false;

  @override
  void initState() {
    super.initState();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 5.0),
                child: Material(
                  elevation: 4.0,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: List.generate(
                        widget.listData.length,
                        (index) => GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                _onTap.call(
                                    itemSelected: widget.listData[index]);
                              },
                              child: widget.builderDropdownItemMenu
                                  .call(context, widget.listData[index]),
                            )),
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
          onTap: _onTap,
          behavior: HitTestBehavior.translucent,
          child: widget.builderDropdownItem.call(context, widget.data)),
    );
  }

  void _onTap({T? itemSelected}) {
    FocusScope.of(context).requestFocus(FocusNode());

    if (itemSelected != null) {
      setState(() {
        widget.data = itemSelected;
      });
      widget.onChange?.call(itemSelected);
    }

    try {
      if (showDropView == false) {
        _overlayEntry = _createOverlayEntry();

        _overlayEntry.addListener(() {
          showDropView = !showDropView;
        });
        widget.initOverlayEntry?.call(_overlayEntry);
        Overlay.of(context)?.insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
      }
    } catch (error) {
      rethrow;
    }
  }
}
