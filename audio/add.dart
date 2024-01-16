import 'package:audioplayers/audioplayers.dart';
//audioplayers: ^5.2.1
class _MainScreenState extends State<MainScreen> {
  late AudioPlayer audioPlayer;
  // String audioPath = '/succes.mp3'; 


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer();


  }
  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
  Future<void> play(String audioPath) async {
    final response = await audioPlayer.play(AssetSource(audioPath));
  }