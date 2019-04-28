import 'package:xml/xml.dart';

class RssCategory {
  final String domain;
  final String value;
  final String textAttr;

  RssCategory(this.domain, this.value, this.textAttr);

  factory RssCategory.parse(XmlElement element) {
    if (element == null) {
      return null;
    }
    var domain = element.getAttribute("domain");
    var value = element.text;
    var textAttr = element.getAttribute("text");

    return RssCategory(domain, value, textAttr);
  }

  @override
  String toString() => 'RssCategory{domain: $domain, value: $value, textAttr: $textAttr}';
}
