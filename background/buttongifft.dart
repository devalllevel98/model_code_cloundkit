    InkWell(
      onTap: () {
        setState(() {
          _score++;
        });
      },
      child: Container(
        width: 250, // Đặt chiều rộng của Container là 200
        height: 250,
        color: Colors.white, // Đặt màu nền là trong suốt
        child: Stack(
          children: [
            BackgroundGif(gifPath: "assets/target.gif"),
          ],
        )
        ),
      ),