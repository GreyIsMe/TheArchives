//eslint-disable-next-line
const commando = require('discord.js-commando');
const oneLine = require('common-tags').oneLine;


module.exports = class QTextCommand extends commando.Command {
  constructor(client) {
    super(client, {
      name: 'qtext',
      group: 'fun',
      memberName: 'qtext',
      description: 'Translates a message into QBert language.',
      details: oneLine `
        Do you like QBert's language?
        This command translates what you give it into QBert language.
			`,
      examples: ['qtext lelelelel this is in QBert language'],
      args: [{
        key: 'toQtext',
        label: 'qtext',
        prompt: 'What would you like to translate?',
        type: 'string',
        infinite: false
      }]
    })
  }

  //eslint-disable-next-line class-methods-use-this
  async run(message) {
    //eslint-disable-next-line newline-per-chained-call
    let toQbert = message.content.split(' ').slice(1).join(' ')

    function randomtext() {
      let text = '';
      let possible = '@#%><?!&^+=';

      for (let i = 0;i < toQbert.length;i++) text += possible.charAt(Math.floor(Math.random() * possible.length));

      return text;
    }

    let qbert = randomtext()
    message.delete(1)
      .then(() => {
        message.channel.send(qbert)
      })
  }
};
