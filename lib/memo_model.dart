class MovieModel {
  final String id;
  final String title;
  final String content;
  final String image;

  MovieModel(this.id, this.title, this.content , this.image);

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      "id": id,
      "title": title,
      "content": content,
      "image": image,
    };
  }
}
