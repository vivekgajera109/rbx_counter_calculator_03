import 'package:flutter/material.dart';

class Meme {
  final String title;
  final String description;
  final String shareText;

  Meme(
      {required this.title,
      required this.description,
      required this.shareText});
}

class MemeProvider with ChangeNotifier {
  final List<Meme> memes = [
    Meme(
      title: "Spawn Trapping",
      description:
          "Spawning in the middle of chaos like: 'Guess I'll die.' 🤦😭",
      shareText: "Spawn Trapping 😂",
    ),
    Meme(
      title: "Relatable Gamer Meme",
      description: "When your WiFi disconnects mid-game. 📶😭😈",
      shareText: "Relatable Gamer Meme 😂",
    ),
    Meme(
      title: "Robx Trade Offers",
      description:
          "When someone offers you a trade that's clearly not fair: Nice try, buddy. 👀🙄😂",
      shareText: "Robx Trade Offers 😂",
    ),
    Meme(
      title: "Friend Joins After Game Ends",
      description:
          "When your friend joins the server right after you rage-quit. 😡💀🤦",
      shareText: "Friend Joins After Game Ends 😅",
    ),
    Meme(
      title: "Robx Budgeting",
      description:
          "Me: I’ll save my Robx for something special. Also me: buys a hat for 5 Robx 🎩😂",
      shareText: "Robx Budgeting 😂",
    ),
    Meme(
      title: "Roblox Fashion",
      description:
          "When you see someone with a cool fit: I need that in my life! 😍🔥",
      shareText: "Roblox Fashion 😍🔥",
    ),
    Meme(
      title: "Spin Wheel Luck",
      description: "Expectation: Jackpot 🎉 Reality: 5 coins 😭",
      shareText: "Spin Wheel Luck 😭",
    ),
    Meme(
      title: "Daily Login",
      description:
          "Me: I’ll just claim reward. Also me: 3 hours later still playing 🎮😂",
      shareText: "Daily Login Grind 😂",
    ),
    Meme(
      title: "Robx Balance",
      description: "Checks balance: 2 Robx. Items in cart: 200 Robx 🤦‍♂️",
      shareText: "Robx Struggles 🤦‍♂️",
    ),
    Meme(
      title: "Trade Gone Wrong",
      description:
          "Friend: Trust me bro, it’s a fair trade. Also friend: disappears 👻",
      shareText: "Trade Gone Wrong 👻",
    ),
    Meme(
      title: "Server Lag",
      description: "When you lag at the final boss: 🐌💔",
      shareText: "Lag Strikes Again 🐌",
    ),
    Meme(
      title: "Outfit Flex",
      description:
          "Me: Spends 200 Robx on a cool outfit. Random player: 'Noob' 😂",
      shareText: "Outfit Flex Gone Wrong 😂",
    ),
    Meme(
      title: "Obby Struggle",
      description: "Fails the same jump 20 times 😭 but still says ‘easy’ 😎",
      shareText: "Obby Life 😎😭",
    ),
    Meme(
      title: "Inventory Check",
      description:
          "Me: I have nothing to wear. Also me: 200 shirts in inventory 👕😂",
      shareText: "Inventory Problems 👕",
    ),
    Meme(
      title: "Pet Simulator",
      description:
          "When you spend all day grinding, and your pet still looks lazy 🐶😴",
      shareText: "Pet Simulator Grind 🐶",
    ),
    Meme(
      title: "Robx Flex",
      description:
          "That one friend: ‘I only spent 10 Robx.’ Outfit worth 10,000 Robx 💸",
      shareText: "Robx Flex 💸",
    ),
    Meme(
      title: "Friend Request",
      description: "Sends 100 friend requests 👉 gets 0 accepted 😭",
      shareText: "Friend Request Pain 😭",
    ),
    Meme(
      title: "Game Pass",
      description:
          "Game: Free to play 🎮 Also game: Pay 500 Robx to walk faster 🚶‍♂️💨",
      shareText: "Game Pass Logic 💨",
    ),
    Meme(
      title: "Build Fail",
      description: "Tries to build a mansion. Ends up with a box 🏠😂",
      shareText: "Builder Life 🏠",
    ),
    Meme(
      title: "AFK Farming",
      description: "Leaves game to farm coins 🌾 Comes back: disconnected ❌",
      shareText: "AFK Struggles ❌",
    ),
    Meme(
      title: "Fashion Wars",
      description:
          "Joins a fashion contest. Gets 3rd place to someone wearing bacon hair 🥓😂",
      shareText: "Fashion Wars 🥓",
    ),
    Meme(
      title: "Spin Addiction",
      description:
          "Me: Just one spin. Also me: Spins 20 times and still broke 🎡😭",
      shareText: "Spin Addiction 🎡",
    ),
    Meme(
      title: "Chat Chaos",
      description: "Game chat: 90% ‘abc for roleplay’ 🤯",
      shareText: "Chat Chaos 🤯",
    ),
    Meme(
      title: "Obby Rage",
      description: "Falls at stage 99/100 🔥 Smashes keyboard ⌨️😭",
      shareText: "Obby Rage 😭",
    ),
    Meme(
      title: "Tycoon Life",
      description: "Plays tycoon for 2 hours 🏭 Still hasn’t built a door 🚪😂",
      shareText: "Tycoon Life 🚪",
    ),
    Meme(
      title: "Lucky Spin",
      description:
          "Friend spins once → jackpot 🎉 Me spins 50 times → nothing 💀",
      shareText: "Lucky Spin 💀",
    ),
    Meme(
      title: "Dance Party",
      description: "Game: serious mission 🕵️ Me: still dancing 💃😂",
      shareText: "Dance Party 💃",
    ),
    Meme(
      title: "Trade Flex",
      description: "Offers a stick 🌲 Wants a legendary pet 🐉😂",
      shareText: "Trade Flex 🐉",
    ),
    Meme(
      title: "Lag Dance",
      description: "Character moves 5 seconds after I press W ⏳😂",
      shareText: "Lag Dance ⏳",
    ),
    Meme(
      title: "Robx Goals",
      description: "Plan: Save for game pass. Reality: Buy cool sunglasses 🕶️",
      shareText: "Robx Goals 🕶️",
    ),
    Meme(
      title: "Update Hype",
      description: "Waits all week for update. Update: 1 new hat 🎩",
      shareText: "Update Hype 🎩",
    ),
    Meme(
      title: "Server Troll",
      description: "That one guy: always blocking the door 🚪😂",
      shareText: "Server Troll 🚪",
    ),
    Meme(
      title: "Pro Builder",
      description: "Friend: builds Eiffel Tower 🗼 Me: builds a box 📦",
      shareText: "Pro Builder 📦",
    ),
  ];
}
