import 'dart:core';

import 'package:webfeed/domain/dublin_core/dublin_core.dart';
import 'package:webfeed/domain/rss_cloud.dart';
import 'package:webfeed/domain/rss_image.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';

class RssFeed {
  final String title;
  final String author;
  final String description;
  final String link;
  final List<RssItem> items;

  final RssImage image;
  final RssCloud cloud;
  final List<String> categories;
  final List<String> skipDays;
  final List<int> skipHours;
  final String explicit;
  final List<String> keywords;
  final String lastBuildDate;
  final String lastPubDate;
  final String language;
  final String generator;
  final String copyright;
  final String docs;
  final String managingEditor;
  final String rating;
  final String webMaster;
  final int ttl;
  final DublinCore dc;

  RssFeed({
    this.title,
    this.author,
    this.description,
    this.link,
    this.items,
    this.image,
    this.cloud,
    this.categories,
    this.skipDays,
    this.skipHours,
    this.explicit,
    this.keywords,
    this.lastBuildDate,
    this.lastPubDate,
    this.language,
    this.generator,
    this.copyright,
    this.docs,
    this.managingEditor,
    this.rating,
    this.webMaster,
    this.ttl,
    this.dc,
  });

  factory RssFeed.parse(String xmlString) {
    var document = parse(xmlString);
    XmlElement channelElement;
    try {
      channelElement = document.findAllElements("channel").first;
    } on StateError {
      throw ArgumentError("channel not found");
    }

    return RssFeed(
      title: findElementOrNull(channelElement, "title")?.text,
      author: findElementOrNull(channelElement, "itunes:author")?.text,
      description: findElementOrNull(channelElement, "description")?.text,
      link: findElementOrNull(channelElement, "link")?.text,
      items: channelElement.findElements("item").map((element) {
        return RssItem.parse(element);
      }).toList(),
      image: RssImage.parse(findElementOrNull(channelElement, "image")),
      cloud: RssCloud.parse(findElementOrNull(channelElement, "cloud")),
      categories: channelElement.findElements("itunes:category").map((element) {
        return element.getAttribute("text");
      }).toList(),
      skipDays: findElementOrNull(channelElement, "skipDays")
              ?.findAllElements("day")
              ?.map((element) {
            return element.text;
          })?.toList() ??
          [],
      skipHours: findElementOrNull(channelElement, "skipHours")
              ?.findAllElements("hour")
              ?.map((element) {
            return int.tryParse(element.text ?? "0");
          })?.toList() ??
          [],
      explicit: findElementOrNull(channelElement, "itunes:explicit")?.text,
      keywords:
          findElementOrNull(channelElement, "itunes:keywords").text.split(","),
      lastBuildDate: findElementOrNull(channelElement, "lastBuildDate")?.text,
      lastPubDate: findElementOrNull(channelElement, "pubDate")?.text,
      language: findElementOrNull(channelElement, "language")?.text,
      generator: findElementOrNull(channelElement, "generator")?.text,
      copyright: findElementOrNull(channelElement, "copyright")?.text,
      docs: findElementOrNull(channelElement, "docs")?.text,
      managingEditor: findElementOrNull(channelElement, "managingEditor")?.text,
      rating: findElementOrNull(channelElement, "rating")?.text,
      webMaster: findElementOrNull(channelElement, "webMaster")?.text,
      ttl: int.tryParse(findElementOrNull(channelElement, "ttl")?.text ?? "0"),
      dc: DublinCore.parse(channelElement),
    );
  }

  @override
  String toString() => 'RssFeed{title: $title, author: $author, description: $description, link: $link, items: $items, image: $image, cloud: $cloud, categories: $categories, skipDays: $skipDays, skipHours: $skipHours, explicit: $explicit, keywords: $keywords, lastBuildDate: $lastBuildDate, lastPubDate: $lastPubDate, language: $language, generator: $generator, copyright: $copyright, docs: $docs, managingEditor: $managingEditor, rating: $rating, webMaster: $webMaster, ttl: $ttl, dc: $dc}';

}
