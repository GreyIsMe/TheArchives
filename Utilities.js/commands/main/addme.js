//eslint-disable-next-line
const commando = require('discord.js-commando');
const { readFileSync, writeFileSync } = require('fs');

module.exports = class AddMeCommand extends commando.Command {
  constructor(client) {
    super(client, {
      name: 'addme',
      aliases: ['pushme'],
      group: 'main',
      memberName: 'addme',
      description: 'Adds the message author to the notes database **USE THIS BEFORE USING THE NOTES COMMAND**',
      examples: ['addme']
    });
  }

  async run(message) {
    if (this.client.notes[message.author.id]) {
      message.reply(`You are already in the database, you are free to use \`${message.guild.commandPrefix}note\``)
    } else {
      this.client.notes[message.author.id] = {
        'notes': [{
          'title': 'Hello World!',
          'content': 'Thanks for using Utilities.js!'
        }]
      }
      writeFileSync('./notes.json', JSON.stringify(this.client.notes, null, 2))
      let CurrentNotes = JSON.parse(readFileSync('./notes.json'))
      if (CurrentNotes[message.author.id]) {
        message.reply('Wrote you into the database!')
      }
    }
  }
};
