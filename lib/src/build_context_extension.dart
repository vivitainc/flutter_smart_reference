import 'package:flutter/material.dart';

import 'element_extension.dart';

extension BuildContextFindElementByType on BuildContext {
  /// Elementの子孫を辿り、指定の型のWidgetを検索する.
  /// 特定Interfaceを検索できるよう、型はWidgetに限定しない.
  ///
  /// [returnOnFound] がtrue(default)の場合、
  /// 指定型を発見した時点で更に子孫は検索しない.
  Set<Element> findElementByType<TWidget>({
    bool returnOnFound = true,
  }) {
    final result = <Element>{};
    visitChildElements(
      (element) => element.findElementByType<TWidget>(result),
    );
    return result;
  }
}
