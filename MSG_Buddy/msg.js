// Modules
const { Client, RichEmbed } = require('discord.js');
const oneLine = require('common-tags').oneLine;
const apiai = require('apiai');
const ms = require('ms');
const fs = require('fs');
//const childProcess = require('child_process')
// Init important stuff
const client = new Client();

// JSON
const config = require('./config.json');
const games = [`${config.prefix}help | ${client.guilds.size} servers`, 'with Sky', 'with Chrono', 'Half Life 3 Closed Beta', 'Portal Stories: Mel', 'with GLaDOS', 'with my code', 'with Linode', '😈'];
let afkUsers = require('./afk.json');
const help = require('./help.json');

const app = apiai(config.apiai);

let token = config.token;
let prefix = config.prefix;

setInterval(() => {
  function log() {
    console.log('Wrote afk users to file.');
  }
  fs.writeFile('./afk.json', JSON.stringify(afkUsers, null, 2), {
    encoding: 'utf8'
  }, log);
  let randomInt = Math.floor(Math.random() * games.length) + 0
  let game = games[randomInt]
    client.user.setPresence({
      game: {
      name: game,
      type: 0
  }
  }).then(() => {
      console.log('Game set.');
  });
}, ms('30s'));

client.on('ready', () => {
  console.log(`${client.user.username}, READY FOR CHAT IN ${client.guilds.size} servers`);
  console.log('Listing guilds:');
  client.guilds.map((guild) => {
    console.log(`Guild: ${guild.id}
Name: ${guild.name}
Owner: ${guild.owner.user.tag} (${guild.owner.id})
Members: ${guild.members.size}
Humans: ${guild.members.filter(u => !u.user.bot).size} (${Math.floor(guild.members.filter(u => !u.user.bot).size / guild.members.size * 100)}%)
Bots: ${guild.members.filter(u => u.user.bot).size} (${Math.floor(guild.members.filter(u => u.user.bot).size / guild.members.size * 100)}%)`)
  });
});

client.on('guildCreate', (guild) => {
  console.log(`New guild added:
Guild: ${guild.id}
Name: ${guild.name}
Owner: ${guild.owner.user.tag} (${guild.owner.id})
Members: ${guild.members.size}
Bots: ${guild.members.filter(u => u.user.bot).size} (${Math.floor(guild.members.filter(u => u.user.bot).size / guild.members.size * 100)}%)
Humans: ${guild.members.filter(u => !u.user.bot).size} (${Math.floor(guild.members.filter(u => !u.user.bot).size / guild.members.size * 100)}%)
Now on: ${client.guilds.size} servers`);
  client.channels.get('330701184698679307').send(`New guild added:
Guild: ${guild.id}
Name: ${guild.name}
Owner: ${guild.owner.user.tag} (${guild.owner.id})
Members: ${guild.members.size}
Bots: ${guild.members.filter(u => u.user.bot).size} (${Math.floor(guild.members.filter(u => u.user.bot).size / guild.members.size * 100)}%)
Humans: ${guild.members.filter(u => !u.user.bot).size} (${Math.floor(guild.members.filter(u => !u.user.bot).size / guild.members.size * 100)}%)
Now on: ${client.guilds.size} servers`);
  // let botPercentage = Math.floor(guild.members.filter(u => u.user.bot).size / guild.members.size * 100)
  // if (botPercentage >= 80) {
  //   guild.defaultChannel.send('**ALERT:** Your guild has been marked as an illegal guild. \nThis may be due to it being marked as a bot guild or marked as a spam guild. \nThe bot will now leave this server. \nIf you wish to speak to my developer, you may join here: https://discord.gg/t8xHbHY')
  //   guild.owner.send(`**ALERT:** Your guild, "${guild.name}", has been marked as an illegal guild. \nThis may be due to it being marked as a bot guild or marked as a spam guild. \nThe bot will now leave the server. \nIf you wish to speak to my developer, you may join here: https://discord.gg/t8xHbHY`)
  //   guild.leave()
  //   //eslint-disable-next-line newline-before-return
  //   return
  // }
  client.user.setPresence({
    game: {
      name: `${config.prefix}help | ${client.guilds.size} servers`,
      type: 0
    }
  });
  const embed = new RichEmbed()
    .setAuthor(client.user.username, client.user.avatarURL)
    .setTitle(`Hello, I'm ${client.user.username}!`)
    .setColor(0x00FF00)
    .setDescription(`Thanks for adding me to your server! To see commands do ${guild.commandPrefix}help. Please note: By adding me to your server and using me, you affirm that you agree to [our TOS](http://smore.romtypo.com/tos.html).`)
  guild.defaultChannel.send({ embed })
  guild.owner.send({ embed })
});
client.on('guildDelete', (guild) => {
  console.log(`Existing guild left:
Guild: ${guild.id}
Name: ${guild.name}
Owner: ${guild.owner.user.tag} (${guild.owner.id})
Members: ${guild.members.size}
Bots: ${guild.members.filter(u => u.user.bot).size} (${Math.floor(guild.members.filter(u => u.user.bot).size / guild.members.size * 100)}%)
Humans: ${guild.members.filter(u => !u.user.bot).size} (${Math.floor(guild.members.filter(u => !u.user.bot).size / guild.members.size * 100)}%)
Now on: ${client.guilds.size} servers`)
  client.channels.get('330701184698679307').send(`Existing guild left:
Guild: ${guild.id}
Name: ${guild.name}
Owner: ${guild.owner.user.tag} (${guild.owner.id})
Members: ${guild.members.size}
Bots: ${guild.members.filter(u => u.user.bot).size} (${Math.floor(guild.members.filter(u => u.user.bot).size / guild.members.size * 100)}%)
Humans: ${guild.members.filter(u => !u.user.bot).size} (${Math.floor(guild.members.filter(u => !u.user.bot).size / guild.members.size * 100)}%)
Now on: ${client.guilds.size} servers`)
  client.user.setPresence({
    game: {
      name: `${config.prefix}help | ${client.guilds.size} servers`,
      type: 0
    }
  })
});

client.on('message', msg => {
  if (msg.author.bot) return;

  // AFK Handler
  if (afkUsers[msg.author.id]) {
    if (afkUsers[msg.author.id].afk === true) {
      msg.reply('Welcome back, I have removed your AFK.');
      afkUsers[msg.author.id].afk = false;
      console.log(`User "${msg.author.username}" is no longer afk.`)
    }
  }

  if (msg.mentions) {
    msg.mentions.users.map((user) => {
      if (afkUsers[user.id]) {
        if (afkUsers[user.id].afk === true) {
          msg.reply(`${user.username} is AFK: \`${afkUsers[user.id].status}\``);
        }
      }
    })
  }

  // Chat Features
  if (msg.mentions.users.first() === client.user) {
    const content = msg.content.split(/\s+/g).slice(1).join(' ');
    console.log(content);
    let request = app.textRequest(content, {
      sessionId: 'CHRONO_IS_BEST'
    });

    request.on('response', function (response) {
      if (response.result.fulfillment.speech === '') {
        msg.reply('I don\'t know what to say to that.')
      } else {
        msg.channel.send(response.result.fulfillment.speech)
        //console.log(response);
      }
    });

    request.on('error', function (error) {
      console.log(error);
    });

    request.end();
  }

  // Commands
  if (msg.content.startsWith(prefix) === false) return;
  const args = msg.content.split(/\s+/g).slice(1).join(' ');
  const cmd = msg.content.split(' ').slice()[0];

  switch (cmd.toLowerCase()) {
    case `${prefix}ping`:
      {
        msg.reply('Pinging...').then((pingmessage) => {
          pingmessage.edit(oneLine `
                ${msg.channel.type !== 'dm' ? `${msg.author},` : ''}
                Pong! The message round-trip took ${pingmessage.createdTimestamp - msg.createdTimestamp}ms.`);
          console.log(`User "${msg.author.username}" ran command "ping"`)
        });
        break;
      }
    case `${prefix}afk`:
      {
        if (afkUsers[msg.author.id]) {
          afkUsers[msg.author.id].afk = true;
          afkUsers[msg.author.id].status = args;
          afkUsers[msg.author.id].id = msg.author.id;
          msg.channel.send(`${msg.author.tag}, I have set your afk to \`${afkUsers[msg.author.id].status}\``);
          console.log(`User "${msg.author.username}" is now AFK.`)
        } else {
          afkUsers[msg.author.id] = {
            'afk': false,
            'status': 'Online'
          };
          msg.reply('This message is normal to see if this is your first time using this command. If so, rerun the command. However, if this is not your first time running this command, then please contact Chronomly on the MSG_Buddy server. https://discord.gg/WmFm4VH');
        }
        break;
      }
    case `${prefix}avatar`:
      {
        if (msg.author.id !== '1') {
          let avatarArgs = msg.content.split(' ');
          let avatarOthers = msg.mentions.users.first();
          avatarArgs = avatarArgs.slice(1);
          avatarArgs = avatarArgs.join(' ');
          if (avatarArgs === '') {
            msg.reply(msg.author.displayAvatarURL);
            console.log(`User "${msg.author.username}" ran command "avatar"`);
          } else {
            msg.reply(avatarOthers.displayAvatarURL);
            console.log(`User "${msg.author.username}" ran command "avatar"`);
          }
        } else {
          msg.reply('Planned mainenence on this command, sorry!');
        }
        break;
      }
    case `${prefix}gann`:
      {
        if (msg.author.id === '156019409658314752' || msg.author.id === '251383432331001856') {
          let gannIn = msg.content.split(' ');
          console.log(gannIn);
          let gannProcess = gannIn.slice(1);
          console.log(gannProcess);
          let gannOut = gannProcess.join(' ');
          console.log(gannOut);
          //eslint-disable-next-line
          client.guilds.map((guild) => {
            let sayit = gannOut
            guild.defaultChannel.send(sayit)
          })
        }
        break;
      }
    case `${prefix}announce`:
      {
        if (msg.author.id === '156019409658314752' || msg.author.id === '251383432331001856') {
          const embed = new RichEmbed()
            .setAuthor('New Announcement', client.user.avatarURL)
            .setDescription(args)
            .setFooter(`From ${msg.author.tag}`, msg.author.avatarURL)
            .setTimestamp()
          client.channels.get('310742003556286464').send({
            embed: embed
          })
          msg.reply('Announcement sent!')
          console.log(`User "${msg.author.username}" ran command "announce"`)
        } else {
          msg.reply('You"re not one of my developers!')
          console.log(`User "${msg.author.username}" tried to run command "announce"`)
        }
        break;
      }
    case `${prefix}eval`:
      {
        if (msg.author.id === '156019409658314752' || msg.author.id === '251383432331001856') {
          msg.channel.send('Evaling...').then((evaling) => {
            let code;
            try {
              //eslint-disable-next-line no-useless-escape
              if (msg.content.includes('token') || msg.content.includes('\`token\`')) return msg.channel.send('The message was censored because it contained sensitive information!');
              //eslint-disable-next-line no-eval
              code = eval(msg.content.split(' ').slice(1).join(' '));
              //if (typeof code !== "string") code = util.inspect(code);
              console.log(`User "${msg.author.username}" ran command "eval"`)
            } catch (err) {
              code = err.essage;
            }
            let evaled = `:inbox_tray: **Input:**\`\`\`js\n${msg.content.split(' ').slice(1).join(' ')}\`\`\`\n\n:outbox_tray: **Output:**\n\`\`\`js\n${code}\`\`\``;
            const embed = new RichEmbed()
              .setAuthor(`${msg.author.tag}`, `${msg.author.avatarURL}`)
              .setColor(0x0000FF)
              .setDescription(`${evaled}`)
              .setFooter('')
              .setTimestamp()
            evaling.edit({
              embed: embed
            })
          })
        } else {
          msg.reply('You"re not one of my developers!')
          console.log(`User "${msg.author.username}" tried to run command "eval"`)

        }
        break;
      }
    case `${prefix}support`:
      {
        const embed = new RichEmbed()
          .setAuthor('Support links', client.user.avatarURL)
          .addField('Come and chill at our server', 'https://discord.gg/WmFm4VH')
          .addField('Check out our website!', 'http://msgbuddy.me')
          .addField('Consider donating to us on Patreon', 'https://www.patreon.com/msgbuddy')
          .setTimestamp();
        msg.channel.send({
          embed: embed
        })
        console.log(`User "${msg.author.username}" ran command "support"`)
        break;
      }
    case `${prefix}invite`:
      {
        const embed = new RichEmbed()
          .setAuthor('Thanks for wanting to add me!', client.user.avatarURL)
          .addField('Bot Invite', 'https://discordapp.com/oauth2/authorize?client_id=310148021835005954&scope=bot&permissions=8')
          .addField('Consider donating to us on Patreon', 'https://www.patreon.com/msgbuddy')
          .setTimestamp();
        msg.channel.send({
          embed: embed
        })
        console.log(`User "${msg.author.username}" ran command "invite"`)
        break;
      }
    case `${prefix}donate`:
      {
        const embed = new RichEmbed()
          .setAuthor('Any donations would be amazing, thanks for your intrest!', client.user.avatarURL)
          .addField('Consider donating to us on Patreon', 'https://www.patreon.com/msgbuddy')
          .setTimestamp();
        msg.channel.send({
          embed: embed
        })
        console.log(`User "${msg.author.username}" ran command "donate"`)
        break;
      }
    case `${prefix}echo`:
      {
        let echoMsg = msg.content.split(' ');
        echoMsg = echoMsg.slice(1);
        echoMsg = echoMsg.join(' ');
        console.log(echoMsg)
        msg.delete().catch();
        msg.reply(`${echoMsg}`);
        break;
      }
    case `${prefix}info`:
      {
        const embed = new RichEmbed()
        .setAuthor(client.user.username, client.user.avatarURL)
        .setColor(0x0099cc)
        .setTitle(':information_source:')
        .addField('Main information:', 'I am a Discord Bot made in **JavaScript** using the Discord API Wrapper **Discord.js**.', false)
        .addField('Developers:', '• Chronomly • TJDoesCode • Sky •', false)
        .addField('Server Count:', `${client.guilds.size}`, true);
        msg.channel.send({ embed: embed })
        break;
      }
    case `${prefix}help`:
      {
          const embed = new RichEmbed()
          .setAuthor('Help!', client.user.avatarURL)
          .setTimestamp()
            help.commands.map((cmd) => {
              embed.addField(cmd.name, cmd.desc)
            });
          msg.author.send({
            embed: embed
          });
          msg.author.send('Come join our server! We offer bot support and a nice place to relax!\nhttps://discord.gg/WmFm4VH\nDonate to us on patreon!\nhttps://www.patreon.com/msgbuddy').then(() => {
            msg.reply('Check your DMs! 📬')
            console.log(`User "${msg.author.username}" ran command "help"`)
          })
        break;
      }
      case `${prefix}devhelp`:
      {
        if (msg.author.id === '156019409658314752' || msg.author.id === '251383432331001856') {
				const embed = new RichEmbed()
          .setAuthor('Help!', client.user.avatarURL)
          .setTimestamp()
        help.dev.map((cmd) => {
          embed.addField(cmd.name, cmd.desc)
        });
        msg.author.send({
          embed: embed
        });
        msg.author.send(':wink:').then(() => {
          msg.reply('Check your DMs! 📬')
          console.log(`User "${msg.author.username}" ran command "help"`)
        })
      }
      break;
    }
      case `${prefix}listguilds`:
      {
        if (msg.author.id === '156019409658314752' || msg.author.id === '251383432331001856') {
        client.guilds.map((guild) => {
          msg.channel.send(`Guild: ${guild.id}
    Name: ${guild.name}
    Owner: ${guild.owner.user.tag} (${guild.owner.id})
    Members: ${guild.members.size}
    Humans: ${guild.members.filter(u => !u.user.bot).size} (${Math.floor(guild.members.filter(u => !u.user.bot).size / guild.members.size * 100)}%)
    Bots: ${guild.members.filter(u => u.user.bot).size} (${Math.floor(guild.members.filter(u => u.user.bot).size / guild.members.size * 100)}%)`)
        })
      }
        break;
      }
      case `${prefix}fleave`:
      {
        if (msg.author.id === '156019409658314752' || msg.author.id === '251383432331001856') {
          let guild = client.guilds.get(args[1])
          guild.defaultChannel.send('**ALERT:** Your guild has been marked as an illegal guild. \nThis may be due to it being marked as a bot guild or marked as a spam guild. \nThe bot will now leave this server. \nIf you wish to speak to my developer, you may join here: https://discord.gg/6P6MNAU')
          guild.leave()
          msg.reply('Left guild.')
        }
        break;
      }
      default: {
        //eslint-disable-next-line no-useless-return
        return;
      }
  }

  /* if(msg.content.startsWith(prefix + 'exec')) {
       if(msg.author.id === '156019409658314752' || msg.author.id === '251383432331001856') {
           let toExec = msg.content.split(" ").slice(1);
           childProcess.exec(args, {},
           (err, stdout, stderr) => {
          if (err) return msg.channel.sendCode("", err.message)
           msg.channel.sendCode("", stdout)
       })
   }
   else {
       msg.reply('You"re not one of my developers!')
       console.log(`User "${msg.author.username}" tried to run command "exec"`)
  } */

});

client.login(token);
