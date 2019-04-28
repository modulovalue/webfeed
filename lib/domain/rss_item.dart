import 'package:webfeed/domain/dublin_core/dublin_core.dart';
import 'package:webfeed/domain/media/media.dart';
import 'package:webfeed/domain/rss_category.dart';
import 'package:webfeed/domain/rss_content.dart';
import 'package:webfeed/domain/rss_enclosure.dart';
import 'package:webfeed/domain/rss_source.dart';
import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';

class RssItem {
  final String title;
  final String description;
  final String link;

  final List<RssCategory> categories;
  final String guid;
  final String pubDate;
  final String author;
  final String comments;
  final String image;
  final String duration;
  final String explicit;
  final String episodeId;
  final List<String> keywords;
  final RssSource source;
  final RssContent content;
  final Media media;
  final RssEnclosure enclosure;
  final DublinCore dc;

  RssItem({
    this.title,
    this.description,
    this.link,
    this.categories,
    this.guid,
    this.pubDate,
    this.author,
    this.comments,
    this.image,
    this.duration,
    this.explicit,
    this.episodeId,
    this.keywords,
    this.source,
    this.content,
    this.media,
    this.enclosure,
    this.dc,
  });

  factory RssItem.parse(XmlElement element) {
    return RssItem(
      title: findElementOrNull(element, "title")?.text,
      description: findElementOrNull(element, "description")?.text,
      link: findElementOrNull(element, "link")?.text,
      categories: element.findElements("category").map((element) {
        return RssCategory.parse(element);
      }).toList(),
      guid: findElementOrNull(element, "guid")?.text,
      pubDate: findElementOrNull(element, "pubDate")?.text,
      author: findElementOrNull(element, "author")?.text,
      comments: findElementOrNull(element, "comments")?.text,
      image: findElementOrNull(element, "itunes:image")?.getAttribute("href"),
      duration: findElementOrNull(element, "itunes:duration")?.text,
      explicit: findElementOrNull(element, "itunes:explicit")?.text,
      episodeId: findElementOrNull(element, "itunes:episode")?.text,
      keywords: findElementOrNull(element, "itunes:keywords")?.text?.split(","),
      source: RssSource.parse(findElementOrNull(element, "source")),
      content: RssContent.parse(findElementOrNull(element, "content:encoded")),
      media: Media.parse(element),
      enclosure: RssEnclosure.parse(findElementOrNull(element, "enclosure")),
      dc: DublinCore.parse(element),
    );
  }

  @override
  String toString() => 'RssItem{title: $title, description: $description, link: $link, categories: $categories, guid: $guid, pubDate: $pubDate, author: $author, comments: $comments, image: $image, duration: $duration, explicit: $explicit, episodeId: $episodeId, keywords: $keywords, source: $source, content: $content, media: $media, enclosure: $enclosure, dc: $dc}';
}
