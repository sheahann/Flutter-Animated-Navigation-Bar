# Custom animated bottom navigation bar for flutter applications

https://user-images.githubusercontent.com/61119848/168467099-7564d3bd-8242-408c-b47c-1a43920a8cbb.mp4

## Usage
And example of usage

```dart
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = const [
      Icons.search,
      Icons.account_circle_sharp,
      Icons.refresh_rounded,
      Icons.widgets_rounded,
      Icons.webhook,
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[500],
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: Text(
                "Current BottomNavBar item index: $currentItemIndex",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Positioned(
              right: 10,
              left: 10,
              bottom: 10,
              // Navigation bar
              child: BottomNavBar(
                icons: icons,
                iconSize: 28,
                titleType: NavBarTitleType.never,
                // Don't forget to implement titles if you use NavBarTitleType.always, otherwise you get error
                //titles: const ["home", "profile", "refresh", "menu", "data"],
                activeColor: Colors.blue[500]!,
                inactiveColor: Colors.blue[500]!.withOpacity(0.3),
                // callback returns an index of the current selected icon, here you can load next page or whatever you wish
                onChange: (int callback) {
                  setState(() {
                    currentItemIndex = callback;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Reminder
Dont forget to implement ```titles``` parameter with the exact same length as your ```icons``` parameter if you use ```NavBarTitleType.always``` otherwise you get error
```dart
List<IconData> icons = const [
  Icons.search,
  Icons.account_circle_sharp,
  Icons.refresh_rounded,
  Icons.widgets_rounded,
  Icons.webhook,
];

BottomNavBar(
  icons: icons,
  iconSize: 28,
  titleType: NavBarTitleType.always,
  titles: const ["home", "profile", "refresh", "menu", "data"],
  activeColor: Colors.blue[500]!,
  inactiveColor: Colors.blue[500]!.withOpacity(0.3),
  onChange: (int callback) {
    setState(() {
      currentItemIndex = callback;
    });
  }
)
```
