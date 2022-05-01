import 'dart:io';

void main() async {
  HttpServer.bind("127.0.0.1", 4444).then((HttpServer server) {
    server.listen((HttpRequest request) {
      HttpResponse response = request.response;

      response.headers.contentType = ContentType.html;
      String uri = request.uri.toString();

      if (uri == '/') {
        response.write("<h1>Main Page</h1>");
      } else if (uri == "/users") {
        response.write("<h1>Users Page</h1>");
      } else if (uri == "/contacts") {
        response.write("<h1>Contacts Page</h1>");
      } else {
        response.write("Page Not Found!");
      }
      response.close();
    });
  });
}
