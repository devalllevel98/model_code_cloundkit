Stack(
      children: [
        BackgroundGif(gifPath: "assets/sc.gif",),
        Container( // Background container
          decoration: BoxDecoration(
            color: Colors.transparent, // Màu nền của background
          ),
        ),
        ListView.builder(
          itemCount: _scores.length,
          itemBuilder: (context, index) {
            final scoreInfo = _scores[index].split(':');
            final playerName = scoreInfo[0];
            final scoreDetails = scoreInfo[1];
            return Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      playerName,
                      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20, fontFamily: "impact", fontWeight: FontWeight.bold),
// Màu văn bản
                    ),
                    Text(
                      scoreDetails,
                      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20, fontFamily: "impact", fontWeight: FontWeight.bold),
// Màu văn bản
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ),