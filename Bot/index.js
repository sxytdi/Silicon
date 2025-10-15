import { Client, GatewayIntentBits } from "discord.js";
import fetch from "node-fetch";

const client = new Client({
  intents: [
    GatewayIntentBits.Guilds,
    GatewayIntentBits.GuildMessages,
    GatewayIntentBits.MessageContent,
  ],
});

const SUPPORT_PATTERN = /^support-/i;
const PURCHASE_PATTERN = /^purchase-/i;

const userStats = {};

client.once("ready", () => {
  console.log(`Logged in as ${client.user.tag}`);
});

client.on("messageCreate", (message) => {
  if (message.author.bot) return;

  const { author, channel } = message;
  const id = author.id;
  const name = author.username;

  if (!userStats[id]) {
    userStats[id] = {
      name,
      messages: 0,
      support: new Set(),
      purchase: new Set(),
    };
  }

  userStats[id].messages++;

  if (SUPPORT_PATTERN.test(channel.name)) userStats[id].support.add(channel.name);
  if (PURCHASE_PATTERN.test(channel.name)) userStats[id].purchase.add(channel.name);
});

setInterval(async () => {
  try {
    const payload = {};
    for (const [id, data] of Object.entries(userStats)) {
      payload[id] = {
        name: data.name,
        messages: data.messages,
        support: [...data.support],
        purchase: [...data.purchase],
      };
    }

    await fetch(`${process.env.API_URL}/upload`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${process.env.API_KEY}`,
      },
      body: JSON.stringify(payload),
    });

    console.log("Stats uploaded to Cloudflare Worker");
  } catch (err) {
    console.error("Upload failed:", err);
  }
}, 5 * 60 * 1000);

client.login(process.env.DISCORD_TOKEN);
