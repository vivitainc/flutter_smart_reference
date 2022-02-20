import 'package:flutter/material.dart';

extension ElementFindElementByType on Element {
  /// Elementの子孫を辿り、指定の型のWidgetを検索する.
  /// 特定Interfaceを検索できるよう、型はWidgetに限定しない.
  ///
  /// [returnOnFound] がtrue(default)の場合、
  /// 指定型を発見した時点で更に子孫は検索しない.
  void findElementByType<TWidget>(
    Set<Element> result, {
    bool returnOnFound = true,
  }) {
    if (widget is TWidget) {
      result.add(this);
      if (returnOnFound) {
        return;
      }
    }
    visitChildren(
      (child) => child.findElementByType<TWidget>(result),
    );
  }
}
