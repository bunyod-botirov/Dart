import 'dart:io';

void main() async {
  File baseHtml = File("./index.html");
  File usersHtml = File("./users.html");
  File contactsHtml = File("./contacts.html");

  Stream<HttpRequest> server = await HttpServer.bind("127.0.0.1", 4444);

  await for (HttpRequest request in server) {
    HttpResponse response = request.response;
    if (await baseHtml.exists() || await contactsHtml.exists()) {
      response.headers.contentType = ContentType.html;
      String uri = request.uri.toString();
      if (uri == '/') {
        await response.addStream(baseHtml.openRead());
      } else if (uri == "/users") {
        await response.addStream(usersHtml.openRead());
      } else if (uri == "/contacts") {
        await response.addStream(contactsHtml.openRead());
      } else {
        response.write("Page Not Found!");
      }
    } else {
      response.statusCode = 404;
    }
    response.close();
  }
}
