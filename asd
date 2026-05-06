```txt
TECH STACK (PRODUCTION READY)

Frontend:
- NextJS 14
- React
- TailwindCSS
- Framer Motion
- Socket.io Client
- Zustand
- React Query

Backend:
- NodeJS
- Express
- Socket.io
- MongoDB
- JWT Auth
- Redis

Realtime:
- Multiplayer tables
- Live dealer sync
- Betting sync
- Roadmap sync

Features:
✔ AI Dealer
✔ Baccarat Engine
✔ Roadmap thật
✔ Coin system
✔ Mobile responsive
✔ Admin dashboard
✔ Voice dealer
✔ Video dealer
✔ Live casino UI
```

---

# 1. CREATE PROJECT

```bash
npx create-next-app ai-casino
cd ai-casino

npm install tailwindcss framer-motion socket.io-client zustand axios react-hot-toast
```

---

# 2. PROJECT STRUCTURE

```txt
src/
 ├── app/
 ├── components/
 │    ├── table/
 │    ├── roadmap/
 │    ├── dealer/
 │    ├── chips/
 │    └── ui/
 │
 ├── store/
 ├── hooks/
 ├── socket/
 ├── lib/
 ├── services/
 └── styles/
```

---

# 3. NEXTJS LUXURY CASINO UI

## app/page.tsx

```tsx id="jc8fh0"
"use client";

import Dealer from "@/components/dealer/Dealer";
import BaccaratTable from "@/components/table/BaccaratTable";
import Roadmap from "@/components/roadmap/Roadmap";
import Chips from "@/components/chips/Chips";

export default function Home() {

  return (

    <main className="w-screen h-screen bg-black overflow-hidden text-white">

      <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,#0f5c2d,#020202)]"/>

      <Dealer />

      <BaccaratTable />

      <Chips />

      <Roadmap />

    </main>
  );
}
```

---

# 4. AI DEALER COMPONENT

## Dealer.tsx

```tsx id="oq8k7d"
"use client";

import { motion } from "framer-motion";

export default function Dealer() {

  return (

    <motion.div
      initial={{ y: 40, opacity: 0 }}
      animate={{ y: 0, opacity: 1 }}
      transition={{ duration: .8 }}
      className="absolute top-10 left-1/2 -translate-x-1/2 z-20"
    >

      <video
        autoPlay
        muted
        loop
        playsInline
        className="w-[420px] rounded-3xl shadow-2xl"
      >
        <source src="/dealer.mp4" type="video/mp4" />
      </video>

    </motion.div>
  );
}
```

---

# 5. BACCARAT TABLE

## BaccaratTable.tsx

```tsx id="1v5w8m"
"use client";

export default function BaccaratTable() {

  return (

    <div className="absolute bottom-40 left-1/2 -translate-x-1/2
    w-[1100px] h-[360px]
    rounded-[50px]
    border-4 border-yellow-700
    bg-gradient-to-b from-green-700 to-green-950
    shadow-2xl z-10">

      <div className="grid grid-cols-2 h-full">

        <div className="flex flex-col items-center justify-center">

          <h1 className="text-5xl font-bold text-blue-400 mb-8">
            PLAYER
          </h1>

        </div>

        <div className="flex flex-col items-center justify-center">

          <h1 className="text-5xl font-bold text-red-400 mb-8">
            BANKER
          </h1>

        </div>

      </div>

    </div>
  );
}
```

---

# 6. ROADMAP THẬT

## roadmapStore.ts

```ts id="s3y9ke"
import { create } from "zustand";

interface RoadmapStore {

  results: string[];

  addResult: (r:string)=>void;
}

export const useRoadmapStore =
create<RoadmapStore>((set)=>({

  results: [],

  addResult: (r)=>
    set((state)=>({

      results: [...state.results, r]

    }))
}));
```

---

## Roadmap.tsx

```tsx id="v4p72x"
"use client";

import { useRoadmapStore } from "@/store/roadmapStore";

export default function Roadmap() {

  const { results } = useRoadmapStore();

  return (

    <div className="absolute bottom-0 left-0 right-0
    h-[120px]
    bg-black/90
    border-t border-white/10
    flex items-center gap-2 px-5 overflow-x-auto">

      {results.map((r,index)=>(

        <div
          key={index}
          className={`
          w-8 h-8 rounded-full

          ${r==="P" && "bg-blue-500"}
          ${r==="B" && "bg-red-500"}
          ${r==="T" && "bg-green-500"}
          `}
        />

      ))}

    </div>
  );
}
```

---

# 7. SOCKET.IO CLIENT

## socket.ts

```ts id="gtz0bg"
import { io } from "socket.io-client";

export const socket = io("http://localhost:3001");
```

---

# 8. NODE SOCKET SERVER

## server.js

```js id="ehmqkh"
const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const cors = require("cors");

const app = express();

app.use(cors());

const server = http.createServer(app);

const io = new Server(server, {

  cors:{
    origin:"*"
  }
});

const rooms = {};

io.on("connection",(socket)=>{

  console.log("CONNECTED");

  socket.on("join-table",(tableId)=>{

    socket.join(tableId);

    if(!rooms[tableId]){

      rooms[tableId] = {

        players: [],
        roadmap: []
      };
    }
  });

  socket.on("deal",(tableId,result)=>{

    rooms[tableId].roadmap.push(result);

    io.to(tableId).emit("new-result",{

      result,
      roadmap: rooms[tableId].roadmap
    });
  });

});

server.listen(3001,()=>{

  console.log("SERVER RUNNING");
});
```

---

# 9. AI VOICE DEALER

```ts id="f7jv6w"
export function speak(text:string){

  const msg =
  new SpeechSynthesisUtterance(text);

  msg.rate = 1;
  msg.pitch = 1;

  speechSynthesis.speak(msg);
}
```

---

# 10. COIN BETTING SYSTEM

## coinStore.ts

```ts id="7ksgqz"
import { create } from "zustand";

export const useCoinStore = create((set)=>({

  coins: 1000000,

  bet: 0,

  placeBet:(amount:number)=>
    set((state:any)=>({

      coins: state.coins - amount,
      bet: amount
    }))
}));
```

---

# 11. LOGIN / REGISTER

## Mongo User Schema

```js id="pk8umx"
const mongoose = require("mongoose");

const UserSchema =
new mongoose.Schema({

  username:String,

  password:String,

  coins:{
    type:Number,
    default:100000
  }
});

module.exports =
mongoose.model("User",UserSchema);
```

---

# 12. JWT AUTH

```js id="4v8jmh"
const jwt = require("jsonwebtoken");

function generateToken(user){

  return jwt.sign({

    id:user._id

  },"SECRET_KEY");
}
```

---

# 13. ADMIN DASHBOARD

Features:

* User management
* Ban player
* Coin adjustment
* RTP stats
* Table monitoring
* Online users
* Revenue charts

---

# 14. LIVE STREAM CASINO STYLE

Use:

* OBS Studio
* WebRTC
* HLS Streaming
* Agora SDK

Dealer camera:

```tsx id="6f0o1g"
<video
autoPlay
playsInline
muted
/>
```

---

# 15. MOBILE RESPONSIVE

```tsx id="o9j1lm"
className="
w-full
md:w-[1100px]
h-[260px]
md:h-[360px]
"
```

---

# 16. DARK LUXURY EVOLUTION STYLE

Colors:

```css id="z42cm8"
background: #050505;
gold: #d4af37;
green: #0f5c2d;
red: #d63a3a;
blue: #2b6fff;
```

Fonts:

* Poppins
* Montserrat
* Bebas Neue

Effects:

* glassmorphism
* neon glow
* gold borders
* cinematic shadows

---

# 17. REAL BACCARAT ROADMAP

Need:
✔ Big Road
✔ Big Eye Boy
✔ Small Road
✔ Cockroach Pig

Logic:

* columns
* streak detection
* tie stacking
* banker/player chains

---

# 18. DEPLOYMENT

Frontend:

* Vercel

Backend:

* Railway
* Render
* VPS Ubuntu

Database:

* Mongo Atlas

Realtime:

* Redis adapter

---

# 19. PRODUCTION SECURITY

✔ Rate limit
✔ JWT refresh
✔ Anti cheat
✔ DDOS protection
✔ Provably fair
✔ Encrypted socket
✔ Admin roles

---

# 20. NEXT STEP

Bạn nên build theo thứ tự:

1. Baccarat Engine
2. UI
3. Socket realtime
4. Betting system
5. Roadmap
6. Auth
7. MongoDB
8. Admin dashboard
9. AI dealer
10. Voice + animation
11. Streaming
12. Production deploy

```
```
# Kiến trúc hoàn chỉnh cho Baccarat Casino Platform

```txt
CLIENT (NextJS)
 ├── Casino UI
 ├── Baccarat Engine View
 ├── Roadmap
 ├── Betting
 ├── AI Dealer
 ├── Live Stream
 └── Socket.io Client

SERVER (NodeJS)
 ├── Game Engine
 ├── Auth API
 ├── Wallet/Coin
 ├── Socket.io
 ├── Admin APIs
 ├── Match Sync
 └── RTP Analytics

DATABASE
 ├── MongoDB
 ├── Redis
 └── Logs

STREAMING
 ├── WebRTC
 ├── HLS
 └── OBS
```

---

# 1. BACCARAT ENGINE

## Core structure

```txt
engine/
 ├── deck.js
 ├── baccarat.js
 ├── roadmap.js
 ├── rules.js
 └── shuffle.js
```

---

## baccarat.js

```js
class BaccaratEngine {

  constructor() {

    this.player = [];
    this.banker = [];
  }

  start(deck) {

    this.player = [
      deck.draw(),
      deck.draw()
    ];

    this.banker = [
      deck.draw(),
      deck.draw()
    ];

    return this.resolve(deck);
  }

  resolve(deck) {

    const p = total(this.player);
    const b = total(this.banker);

    if (p >= 8 || b >= 8) {
      return this.finish();
    }

    let playerThird = null;

    if (p <= 5) {

      playerThird = deck.draw();

      this.player.push(playerThird);
    }

    if (shouldBankerDraw(
      total(this.banker),
      playerThird
    )) {

      this.banker.push(deck.draw());
    }

    return this.finish();
  }

  finish() {

    return {

      player: this.player,
      banker: this.banker,
      playerTotal: total(this.player),
      bankerTotal: total(this.banker),
      winner: getWinner(
        total(this.player),
        total(this.banker)
      )
    };
  }
}
```

---

# 2. NEXTJS CASINO UI

## Layout

```txt
components/
 ├── Dealer
 ├── Table
 ├── Cards
 ├── Chips
 ├── Roadmaps
 ├── Chat
 ├── Topbar
 └── Statistics
```

---

## Dark luxury design

```tsx
<div className="
bg-gradient-to-b
from-green-900
to-black
border border-yellow-700
shadow-[0_0_40px_rgba(0,0,0,.8)]
rounded-[40px]
"/>
```

---

# 3. SOCKET REALTIME

## Server

```js
io.on("connection", socket => {

  socket.on("join-table", tableId => {

    socket.join(tableId);
  });

  socket.on("bet", data => {

    io.to(data.tableId)
      .emit("player-bet", data);
  });

  socket.on("deal", tableId => {

    const result = game.play();

    io.to(tableId)
      .emit("game-result", result);
  });
});
```

---

## Client

```ts
socket.on("game-result", result => {

  setGame(result);

  playVoice(result.winner);
});
```

---

# 4. BETTING SYSTEM

## Wallet schema

```js
coins: {
  type:Number,
  default:100000
}
```

---

## Place bet

```js
async function placeBet(userId, amount){

  const user =
  await User.findById(userId);

  if(user.coins < amount){

    throw "Not enough coins";
  }

  user.coins -= amount;

  await user.save();
}
```

---

# 5. ROADMAP ENGINE

## Big Road

```js
function buildBigRoad(results){

  const columns = [];

  let current = [];

  results.forEach(r=>{

    if(current.length === 0){

      current.push(r);

    } else {

      if(current[0] === r){

        current.push(r);

      } else {

        columns.push(current);

        current = [r];
      }
    }
  });

  columns.push(current);

  return columns;
}
```

---

# 6. AUTH SYSTEM

## JWT Login

```js
const token = jwt.sign({

  id:user._id

}, process.env.JWT_SECRET);
```

---

## Middleware

```js
function auth(req,res,next){

  const token =
  req.headers.authorization;

  const decoded =
  jwt.verify(token, SECRET);

  req.user = decoded;

  next();
}
```

---

# 7. MONGODB

## Collections

```txt
users
bets
games
transactions
tables
admins
roadmaps
logs
```

---

## Game schema

```js
const GameSchema =
new mongoose.Schema({

  tableId:String,

  winner:String,

  playerCards:Array,

  bankerCards:Array,

  createdAt:{
    type:Date,
    default:Date.now
  }
});
```

---

# 8. ADMIN DASHBOARD

## Features

```txt
✔ User manager
✔ Coin editor
✔ RTP monitor
✔ Active tables
✔ Ban users
✔ Revenue analytics
✔ Fraud detection
✔ Live games
```

---

## Dashboard stack

```txt
NextJS Admin
Chart.js
React Table
Socket.io
```

---

# 9. AI DEALER

## Dealer video

```tsx
<video
autoPlay
loop
muted
playsInline
className="dealer-video"
>
  <source src="/dealer.mp4"/>
</video>
```

---

## Dealer AI speech

```ts
function dealerTalk(text){

  const msg =
  new SpeechSynthesisUtterance(text);

  msg.rate = 1;

  speechSynthesis.speak(msg);
}
```

---

# 10. VOICE + ANIMATION

## Framer Motion

```tsx
<motion.div
initial={{scale:.7,opacity:0}}
animate={{scale:1,opacity:1}}
transition={{duration:.4}}
>
```

---

## Card animation

```css
@keyframes deal {

  from{
    transform:
    translateY(-100px)
    rotate(-20deg);

    opacity:0;
  }

  to{
    transform:
    translateY(0)
    rotate(0);

    opacity:1;
  }
}
```

---

# 11. STREAMING

## Architecture

```txt
Dealer Camera
     ↓
OBS Studio
     ↓
RTMP Server
     ↓
HLS/WebRTC
     ↓
NextJS Client
```

---

## Use

```txt
Agora
LiveKit
Daily.co
MediaSoup
```

---

# 12. PRODUCTION DEPLOY

## Frontend

```txt
Vercel
Cloudflare
```

---

## Backend

```txt
Ubuntu VPS
PM2
Nginx
Docker
```

---

## Database

```txt
Mongo Atlas
Redis Cloud
```

---

## Realtime scaling

```txt
Socket.io Redis Adapter
```

---

# 13. SECURITY

## Required

```txt
✔ Helmet
✔ Rate limit
✔ JWT refresh
✔ HTTPS
✔ WAF
✔ DDOS protection
✔ Anti bot
✔ IP throttle
✔ Coin validation
✔ Transaction logs
```

---

# 14. PERFORMANCE

## Optimization

```txt
✔ Redis cache
✔ Lazy loading
✔ CDN
✔ Video compression
✔ GPU animation
✔ Image optimization
✔ DB indexing
```

---

# 15. CASINO EFFECTS

## Luxury FX

```css
box-shadow:
0 0 20px rgba(212,175,55,.3);
```

---

## Neon animation

```css
animation:
glow 2s infinite alternate;
```

---

# 16. FINAL PRODUCTION STACK

```txt
Frontend:
- NextJS
- Tailwind
- Framer Motion

Backend:
- NodeJS
- Express
- Socket.io

Database:
- MongoDB
- Redis

Streaming:
- WebRTC
- HLS

Infra:
- Docker
- Nginx
- PM2
- Cloudflare
```

---

# 17. BEST DEPLOY FLOW

```txt
LOCAL
 ↓
DEV VPS
 ↓
STAGING
 ↓
PRODUCTION
```

---

# 18. WHAT YOU SHOULD BUILD FIRST

```txt
PHASE 1
✔ Baccarat engine
✔ UI
✔ Cards
✔ Betting

PHASE 2
✔ Socket realtime
✔ Roadmap
✔ Auth
✔ MongoDB

PHASE 3
✔ AI dealer
✔ Voice
✔ Streaming
✔ Admin dashboard

PHASE 4
✔ Scaling
✔ Security
✔ Production deploy
```
