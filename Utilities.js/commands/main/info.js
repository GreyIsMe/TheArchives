//eslint-disable-next-line
const commando = require('discord.js-commando');
const oneLine = require('common-tags').oneLine;
const { RichEmbed } = require('discord.js');

module.exports = class InfoCommand extends commando.Command {
  constructor(client) {
    super(client, {
      name: 'info',
      group: 'main',
      memberName: 'info',
      description: 'Sends you some info about the bot.',
      details: oneLine `
      Do you like this bot? Do you want to learn more about it?
      This command sends you important information about the bot.
			`,
      examples: ['info'],
      guildOnly: true,
      guarded: true
    })
  }

  //eslint-disable-next-line class-methods-use-this
  async run(message) {
    const embed = new RichEmbed()
      .setAuthor(this.client.user.username, this.client.user.avatarURL)
      .setColor(0x0099cc)
      .addField('Main information:', 'I am a Discord Bot made in **JavaScript** using the Discord API Wrapper **Discord.js** on the framework **Discord.js-Commando**', false)
      .addField('Developers:', '• Chronomoly6 • ROM Typo • jdenderplays • TJDoesCode •', false)
      .addField('Server Count:', `${this.client.guilds.size}`, true)
      .addField('Host', 'Not hosted perminatly yet', true)
      .setTimestamp()
    message.channel.send({ embed })
  }
};
