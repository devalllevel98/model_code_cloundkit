                Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Pallete.gradient1,
                          Pallete.gradient2,
                          Pallete.gradient3
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(330, 60),
                    ),
                    onPressed: () {
                      UserId = myController.text;
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen(UserId)));
                      }
                    },
                    child: const Text(
                      "Start",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),