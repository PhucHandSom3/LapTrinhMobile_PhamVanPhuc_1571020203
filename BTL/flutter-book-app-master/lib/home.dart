import 'dart:js';
import 'package:flutter/widgets.dart';
import 'package:book_app/cart_screen.dart';
import 'package:book_app/data.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // App bar
    final appBar = AppBar(
      elevation: .5,
      leading:
      PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'logout') {
            logout(context);
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'logout',
            child: Text('Logout'),
          ),
        ],
        child: Icon(Icons.menu),
      ),
      title: Text('Design Books'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: BookSearchDelegate(),
            );

          },
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            openCartScreen(context);
          },
        ),
      ],
    );

    // Create book tile hero
    createTile(Book book) => Hero(
      tag: book.title,
      child: Material(
        elevation: 15.0,
        shadowColor: Colors.yellow.shade900,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'detail/${book.title}');
          },
          child: Image(
            image: AssetImage(book.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    // Create book grid tiles
    final grid = CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverGrid.count(
            childAspectRatio: 2 / 3,
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: books.map((book) => createTile(book)).toList(),
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appBar,
      body: grid,
    );
  }
}

class BookSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchResults = books.where((book) =>
        book.title.toLowerCase().contains(query.toLowerCase())).toList();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final book = searchResults[index];
        return GestureDetector(
          onTap: () {
            // Xử lý khi người dùng chọn một kết quả tìm kiếm
            // ...
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Hero(
                    tag: book.title,
                    child: Image.network(
                      book.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  book.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? [] // Hiển thị danh sách gợi ý rỗng nếu chưa nhập từ khóa tìm kiếm
        : books
        .where((book) =>
        book.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final book = suggestionList[index];
        return ListTile(
          title: Text(book.title),
          onTap: () {
            Navigator.pushNamed(context, 'detail/${book.title}');
          },
        );
      },
    );
  }
}

void openCartScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CartScreen()),
  );
}
void logout(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/login');
}