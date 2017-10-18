//eslint-disable-next-line
const commando = require('discord.js-commando');
const oneLine = require('common-tags').oneLine;

module.exports = class SettingsCommand extends commando.Command {
  constructor(client) {
    super(client, {
      name: 'settings',
      aliases: ['set', 'setting'],
      group: 'misc',
      memberName: 'settings',
      description: 'Sets or shows server settings.',
      details: oneLine `
				This command allows you to set server settings.
        This is required for many comamnds to work.
        Permission is locked to users with the server administrator permission.
			`,
      examples: ['settings add mod @Moderators'],

      args: [{
          key: 'action',
          label: 'action',
          type: 'string',
          prompt: 'What would you like to do? (View/ Add)',
          infinite: false
        },
        {
          key: 'setting',
          label: 'setting',
          type: 'string',
          prompt: 'What setting would you like?',
          infinite: false
        },
        {
          key: 'value',
          label: 'value',
          type: 'string',
          prompt: '',
          default: '',
          infinite: false
        }
      ],
      guildOnly: true,
      guarded: true
    });
  }

  //eslint-disable-next-line class-methods-use-this
  hasPermission(msg) {
    return msg.member.hasPermission('ADMINISTRATOR');
  }

  //eslint-disable-next-line class-methods-use-this
  async run(message, args) {
    if (args.action.toLowerCase() === 'add') {
      if (args.setting.toLowerCase() === 'starboard') {
        const rawChan = message.mentions.channels.first()
        if (!rawChan) return message.reply('Please specify a channel to use for the starboard!')
        const chanToLog = rawChan.id
        message.guild.settings.set('starboard', chanToLog)
        message.reply(`Set the starboard channel to "<#${message.guild.settings.get('starboard')}>"`)
      } else if (args.setting.toLowerCase() === 'announcements') {
        const state = args.value
        if (state.toLowerCase() === 'on') {
          message.guild.settings.set('announcements', state)
          message.reply(`Set the announcement state to "${message.guild.settings.get('announcements')}" \nDo \`${message.guild.commandPrefix}settings add announcements off\` to re-disable announcements.`)
        } else if (state.toLowerCase() === 'off') {
          message.guild.settings.set('announcements', state)
          message.reply(`Set the announcement state to "${message.guild.settings.get('announcements')}" \nDo \`${message.guild.commandPrefix}settings add announcements on\` to re-enable announcements.`)
          //eslint-disable-next-line no-useless-escape
        } else return message.reply('Invaid state! Use \`on\` or  \`off\`.')
      } else {
        message.reply('That\'s not a setting. Please try again.');
      }
    } else if (args.action.toLowerCase() === 'view') {
      if (args.setting.toLowerCase() === 'starboard') {
        message.reply(`The starboard channel is "<#${message.guild.settings.get('starboard')}>"`)
      } else if (args.setting.toLowerCase() === 'announcements') {
        message.reply(`The announcements state is "${message.guild.settings.get('announcements')}"`)
      } else {
        message.reply('That\'s not a setting. Please try again.');
      }
    } else {
      message.reply('Invalid command usage. Please try again.');
    }
  }
};
