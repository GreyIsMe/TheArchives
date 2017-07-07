local discordia = require('discordia')
local pp = require('pretty-print')
local client = discordia.Client()
	
client:on('ready', function()
    print('Logged in as User: '.. client.user.username)
	print('Printing Server List:')
		for guild in client.guilds do
			print(guild.name .. " / " .. guild.id)
		end
	local f = io.open("DEFAULT_GAME", "rb")
    local content = f:read("*all")
	local game = string.gsub(content, "%s+", "")
    f:close()
	client:setGameName(game)
local f = io.open("PREFIX", "rb")
local content = f:read("*all")
prefix = string.gsub(content, "%s+", "")
f:close()
print('my current prefix is: ' .. prefix)
end)

client:on('guildCreate', function()
	client:setGameName(string.format('s.help | %s servers', client.guildCount))
end)

client:on('guildDelete', function()
	client:setGameName(string.format('s.help | %s servers', client.guildCount))
end)

local function code(str)
	return string.format('```\n%s```', str)
end

local sandbox = setmetatable({}, {__index = _G})

local function prettyLine(...)
	local ret = {}
	for i = 1, select('#', ...) do
		local arg = pp.strip(pp.dump(select(i, ...)))
		table.insert(ret, arg)
	end
	return table.concat(ret, '\t')
end

local function printLine(...)
	local ret = {}
	for i = 1, select('#', ...) do
		local arg = tostring(select(i, ...))
		table.insert(ret, arg)
	end
	return table.concat(ret, '\t')
end

local function exec(arg, msg)

	if not arg then return end
	if msg.author ~= msg.client.owner then return end

	arg = arg:gsub('```\n?', '') -- strip markdown codeblocks

	local lines = {}

	local sandbox = setmetatable({}, {__index = _G})

	sandbox.message = msg

	sandbox.print = function(...)
		table.insert(lines, printLine(...))
	end

	sandbox.p = function(...)
		table.insert(lines, prettyLine(...))
	end

	local fn, syntaxError = load(arg, 'DiscordBot', 't', sandbox)
	if not fn then return msg:reply(code(syntaxError)) end

	local success, runtimeError = pcall(fn)
	if not success then return msg:reply(code(runtimeError)) end

	lines = table.concat(lines, '\n')

	if #lines > 1990 then -- truncate long messages
		lines = lines:sub(1, 1990)
	end

	return msg:reply(code(lines))

end

--Dev Var
CHRONOMLY = "251383432331001856"
JDENDER = "250432205145243649"
ROMTYPO = "186295030388883456"
SPACEX = "220568440161697792"
TJDOESCODE = "197891949913571329"
--TechTeam Var
serverbug = 0
KAYDAX = "142782417994907648"
PUFFLE = "201389895694942210"
STAR = "156019409658314752"
ORANGE = "269543926803726336"

--Commands
client:on('messageCreate', function(message)
	-- exit early if the author is the same as the client
	if message.author == client.user then return end

	-- split the message content into a command and everything else
	local cmd, arg = message.content:match('(%S+)%s+(.*)')
	cmd = cmd or message.content

	if cmd == (string.format(prefix .. 'ping')) then
		local x = os.clock()
		local s = 0
		for i=1,100000 do s = s + i end
		local ccolor = discordia.Color(math.random(255), math.random(255), math.random(255)).value
		local embedmessage = message.channel:sendMessage {
  			embed = {
    			title = ":ping_pong: pong!",
    			color = ccolor,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = message.author.name}
 	 		}
		}
		if not embedmessage then noembedmsg = message.channel:sendMessage(luacode("pong")) end
		if not embedmessage then noembedmsg.content = luacode("pong"..string.format(" - time taken: %.2fs", os.clock() - x)) end
		if embedmessage then embedmessage.embed = {
    		title = ":ping_pong: pong!",
			description = string.format("time taken: %.2fs", os.clock() - x),
    		color = ccolor,
			timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
			footer = {text = message.author.name}
		} end
	end

	if cmd == (string.format(prefix .. 'donate')) then	
		message.channel:sendMessage('Please donate to our host here: https://www.patreon.com/shellshock')
		print(string.format('woah someone is thing about donating known as %s', message.author.username))
	end
	if cmd == (string.format(prefix .. 'google')) then
		message.channel:sendMessage('Searching!')
		local text="https://www.google.com/search?q=" .. arg
		local search = (string.gsub(text, "%s+", '%%20'))
		message.channel:sendMessage {
  embed = {
    title = ":satellite: Here are the results",
    fields = {
      {name = "URL:", value = search, inline = true},
    },
    color = discordia.Color(114, 137, 218).value,
    timestamp = os.date('!%Y-%m-%dT%H:%M:%S')
  }
}
	end
	
    if cmd == (string.format(prefix .. 'smore')) then
        message.channel:sendMessage('https://www.poptarts.com/content/NorthAmerica/pop_tarts/en_US/pages/flavors/bakery/frosted-s-mores-toaster-pastries/jcr:content/productContent/par/responsiveimage.img.png/1475703429032.png')
		print(string.format('s.smore command was used by %s', message.author.id))
    end
	
	if cmd == (string.format(prefix .. 'meme')) then
        message.channel:sendMessage('https://i.imgflip.com/p4v25.jpg')
		print(string.format('s.memez command was used by %s', message.author.id))
    end
	
	if cmd == (string.format(prefix .. 'quote')) then
        message.channel:sendMessage([[i hate git - TJDoesCode]])
		print(string.format('s.quote command was used by %s', message.author.id))
	end
	
	if cmd == (string.format(prefix .. 'fail')) then
		message.channel:sendMessage(string.format('%s, you clearly havent been burdened by the overobundence of education have you?', arg))
		print(string.format('s.fail command was used by %s', message.author.id))
	end

	if cmd == (string.format(prefix .. 'upvoteme')) then
		message:addReaction("👍")
		print(string.format('s.upvoteme command was used by %s', message.author.id))
	end
	
--Bug Command
	if cmd == (string.format(prefix .. 'bug')) then 
		if serverbug == 1 then
			message.channel:sendMessage('Someone already reported a bug please wait for a dev to clear it.')
		end
		if serverbug == 0 then
			message.channel:sendMessage('Bug reported. A helpful person will join your server to help soon')
			local channel = client:getTextChannel("296030986708451328")
			local maxUses = 1
			local maxAge = 1800 
			local invite = message.channel:createInvite(maxAge, maxUses)
			channel:sendMessage(string.format('In %s', message.guild.name)); 
			channel:sendMessage(string.format(' User: %s reported:', message.author.username));
			channel:sendMessage(arg);
			channel:sendMessage('Invite: https://discord.gg/' .. invite.code)
			print(string.format('s.bug command was used by %s to say', message.author.id))print(arg)
			serverbug = 1
		end
	end

	if cmd == (string.format(prefix .. 'clearbug')) then 
		if serverbug == 0 then
			message.channel:sendMessage('No bug to clear :face_palm:')
		end
		if serverbug == 1 then
			if message.author.id == CHRONOMLY or message.author.id == ROMTYPO or message.author.id == JDENDER or message.author.id == SPACEX or message.author.id == KAYDAX  or message.author.id == PUFFLE  or message.author.id == STAR or message.author.id == ORANGE then
				message.channel:sendMessage(':thumbsup:')
				local channel = client:getTextChannel("296030986708451328")
				channel:sendMessage(string.format(message.author.username .. ' cleared a bug in %s', message.guild.name));
				channel:sendMessage(string.format('with the reason, %s', arg))
				print(string.format('s.clearbug command was used by %s with the reason,', message.author.id))print(arg)
				serverbug = 0
			end
		end
	end
	
--Echo Command
	if cmd == (string.format(prefix .. 'echo')) then
	if arg == nil then return end
		message.channel:sendMessage(arg)
		print(string.format('s.echo command was used by %s to say', message.author.id))print(arg)
	end
	
--Info Command
	if cmd == (string.format(prefix .. 'info')) then
		message.channel:sendMessage{
			embed = {
				title = ":information_source:",
				fields = {
					{name = "Main Information", value = [[
I am a Discord Bot made in **Lua** using **Discordia**]], inline = true},
					{name = "Main Developers", value = [[
• Chronomly6
• jdenderplays]], inline = true},
					{name = "JS Version", value = [[
Is being developed by:
• SpaceX
• [ROM Typo](http://romtypo.com/discord)
• TJDoesCode]], inline = false},
					{name = string.format([[I'm in %s servers]],client.guildCount), value = "I'm also hosted by **[ROM Typo](http://romtypo.com/discord)**", inline = false}
				}
			}
		}
		--message.channel:sendMessage(string.format([[
--Hello, I am SmoreBot,
--I am a Discord Bot made in **Lua** using **Discordia**, I am developed by Chronomly6 and jdenderplays, with a JS version being made by SpaceX and ROM Typo and TJDoesCode, also I am in %s servers.]], client.guildCount
--))
			
		print(string.format('s.info was used by %s', message.author.id))
	end
	
--Help Command
	if cmd == 's.@290228059599142913>' then
	message.channel:sendMessage('Help Sent! :mailbox_with_mail:')message.author:sendMessage{
  embed = {
    title = "Command List",
        fields = {
      {name = "Main Commands", value = [[
s.echo (text) - says what you say where it says "text"
s.memez - shows you the memes
s.ping - pings the bot
s.smore - shows you some poptarts
s.quote - a quote from jdenderplays
s.help - this message
s.fail - insults you in DMs
s.partners - dm's you a list of discord servers partnered with SmoreBot!]], inline = true},
      {name = "Bot Info & s.bug", value = [[
s.join - some important links
s.info - some info about the bot
s.bug (the issue) - Reports a bug - help will come as soon as the team can.]], inline = true},
      {name = "Music", value = "Sorry, really buggy", inline = true},
	  {name = "Utility", value = [[
		  s.google (your search) - searches google :face_palm:
	  ]], inline = true},
    },
    color = discordia.Color(114, 137, 218).value,
    timestamp = os.date('!%Y-%m-%dT%H:%M:%S')
  }
}
		print(string.format('s.help command was used by %s', message.author.id))
    end	
	
	if cmd == (string.format(prefix .. 'help')) then
    message.channel:sendMessage('Help Sent! :mailbox_with_mail:')message.author:sendMessage{
   embed = {
    title = "Command List",
        fields = {
      {name = "Main Commands", value = [[
s.echo (text) - says what you say where it says "text"
s.memez - shows you the memes
s.ping - pings the bot
s.smore - shows you some poptarts
s.quote - a quote from jdenderplays
s.help - this message
s.fail - insults you in DMs
s.partners - dm's you a list of discord servers partnered with SmoreBot!]], inline = true},
      {name = "Bot Info & s.bug", value = [[
s.join - some important links
s.info - some info about the bot
s.bug (the issue) - Reports a bug - help will come as soon as the team can.]], inline = true},
      {name = "Music", value = "Sorry, really buggy", inline = true},
	  {name = "Utility", value = [[
		  s.google (your search) - searches google :face_palm:
	  ]], inline = true},
	  },
    color = discordia.Color(114, 137, 218).value,
    timestamp = os.date('!%Y-%m-%dT%H:%M:%S')
  }
}
print(string.format('s.help command was used by %s', message.author.id))
end
if cmd == (string.format(prefix .. 'help')) then
		if message.author.id == CHRONOMLY or message.author.id == ROMTYPO or message.author.id == JDENDER or message.author.id == SPACEX then
    message.author:sendMessage{
  embed = {
    title = "Dev Commands",
        fields = {
{name = "List", value = [[
s.sendall - sends a message to every server the bot is in
s.reboot - reboots the bot ;)
s.game - sets the bots playing status
s.announce (text) - announces something in #announcecements
s.leaveserver (id) - leaves the server
s.update - grabs changes from github
s.ban - what you think it does
s.kick - what you think it does]], inline = true},
	},
	color = discordia.Color(114, 137, 218).value,
    timestamp = os.date('!%Y-%m-%dT%H:%M:%S')
	}
	}
	print(string.format('a dev used s.help, known as %s', message.author.id))
	end
end
--Partners Command
	if cmd == (string.format(prefix .. 'partners')) then
		message.channel:sendMessage('List Sent! :mailbox_with_mail:')message.author:sendMessage([[
		**Partner List**
		```
		Coder Lounge - Chronomly6's Server - https://discord.gg/XCmxErJ
		Project Placeholder5 - IDK WHAT THIS PLACE IS - https://discord.gg/ZtgQ62X
		Chillax Zone - A pretty chill server - https://discord.gg/YabxP6P
		Fun Message Lite - a chill and chat server - discord.gg/hVDzyZd
		FireTrap - A cool bot - https://discordapp.com/oauth2/authorize?client_id=278539150699790347&scope=bot&permissions=8
		Single Helix - the server of DNA - https://discord.gg/hZGhcxJ
		Irish Squad - "Come be potatoes with us" Jackraw 2017 - https://discord.gg/qBMuYrx
		```
		__`ShellShock`__
		• With the shutdown of Helix, and me (ROM Typo) being a dev of it, I've decided to keep the bot alive for everyone.

		Add the bot here:
		• http://romtypo.com/bots/helix

		Join my server:
		• http://discord.gg/ywBWwh6
		]])
		print(string.format('s.partners command was used by %s', message.author.id, '/', message.author.username))
    end	
	
--Bot Adding Info
	if message.content == (string.format(prefix .. 'join')) then
            message.channel:sendMessage {
  embed = {
    title = "Here are some important links",
	    fields = {
      {name = "here is the link to add the bot: ", value = "https://discordapp.com/oauth2/authorize?client_id=290228059599142913&scope=bot&permissions=8", inline = true},
      {name = "here is the link to our website: ", value = "https://smorebot.github.io", inline = true},
	  {name = "here is a link to our support/updates discord:", value = "https://discord.gg/6P6MNAU", inline = true},
      {name = "Our official Twitter:", value = "https://twitter.com/smoresoftware", inline = true},
    },
    color = discordia.Color(114, 137, 218).value,
    timestamp = os.date('!%Y-%m-%dT%H:%M:%S')
  }
}
    end

--Dev Commands	
	if cmd == (string.format(prefix .. 'exec')) then
    if message.author.id == CHRONOMLY or message.author.id == ROMTYPO or message.author.id == JDENDER or message.author.id == SPACEX or message.author.id == TJDOESCODE then
		msg = message
        if exec(arg, msg, fs) then
		print(string.format(prefix .. "exec command was used by %s", message.author.id))
		end
		end
		if message.author.id ~= CHRONOMLY and message.author.id ~= ROMTYPO and message.author.id ~= JDENDER and message.author.id ~= SPACEX and message.author.id ~= TJDOESCODE then
			message.channel:sendMessage('```Error2.1``````You do not have Role: Dev```')
			print(string.format('%s tried to use s.exec', message.author.id)) 
		end
    end

	if cmd == (string.format(prefix .. 'kick')) then
    if message.author.id == CHRONOMLY or message.author.id == ROMTYPO or message.author.id == JDENDER or message.author.id == SPACEX or message.author.id == TJDOESCODE then
        local id = arg:match('<@!?([0-9]+)>')
          if id then
		  user = client:getUser(id)
            message.guild:kickUser(user)
            message.channel:sendMessage(string.format('SUMMONING THE KICK HAMMER ON: %s', id))
            print(string.format('s.kick command was used by %s', message.author.id))
			end
		end
		if message.author.id ~= CHRONOMLY and message.author.id ~= ROMTYPO and message.author.id ~= JDENDER and message.author.id ~= SPACEX and message.author.id ~= TJDOESCODE then
			message.channel:sendMessage('```Error2.1``````You do not have Role: Dev```')
			print(string.format('%s tried to use s.kick', message.author.id)) 
		end
    end
	
	if cmd == (string.format(prefix .. 'ban')) then
    if message.author.id == CHRONOMLY or message.author.id == ROMTYPO or message.author.id == JDENDER or message.author.id == SPACEX or message.author.id == TJDOESCODE then
        local id = arg:match('<@!?([0-9]+)>')
          if id then
		  user = client:getUser(id)
            message.guild:banUser(user)
            message.channel:sendMessage(string.format('SUMMONING THE BAN HAMMER ON: %s', id))
            print(string.format('s.ban command was used by %s', message.author.id))
			end
		end
		if message.author.id ~= CHRONOMLY and message.author.id ~= ROMTYPO and message.author.id ~= JDENDER and message.author.id ~= SPACEX and message.author.id ~= TJDOESCODE then
			message.channel:sendMessage('```Error2.1``````You do not have Role: Dev```')
			print(string.format('%s tried to use s.ban', message.author.id)) 
		end
	end
	
    if cmd == (string.format(prefix .. 'host')) then
		local handle = io.popen("hostname")
		local host = handle:read("*a")
		handle:close()
			
		local handle = io.popen("git remote -v")
		local github = handle:read("*a")
		handle:close()
			
		local ccolor = discordia.Color(math.random(255), math.random(255), math.random(255)).value
		local embedmessage = message.channel:sendMessage {
  			embed = {
    			title = "<:github:295243074353758209> Host Data <:rom:320023323738112001><:server:324607157028913152>",
			fields = {
				{name = "__Host__", value = string.format("`%s`",host), inline = true},
				{name = "__Github__", value = string.format("```%s```",github), inline = true}
			},
    			color = ccolor,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = "ROM is best, ROM is life"}
 	 		}
		}
			
		--message.channel:sendMessage(string.format("I am hosted on `%s`\nGithub Host Data:\n ```%s```",host,github))
	end

	if cmd == (string.format(prefix .. 'update')) then
		if message.author.id == CHRONOMLY or message.author.id == ROMTYPO or message.author.id == JDENDER or message.author.id == SPACEX or message.author.id == TJDOESCODE then
		message.channel:sendMessage(":wave: grabbing from github!")
		client:stop(true)
		end
		if message.author.id ~= CHRONOMLY and message.author.id ~= ROMTYPO and message.author.id ~= JDENDER and message.author.id ~= SPACEX and message.author.id ~= TJDOESCODE then
			message.channel:sendMessage('```Error2.1``````You do not have Role: Dev```')
			print(string.format('%s tried to use s.reboot', message.author.id)) 
		end
	end
	
	if cmd == (string.format(prefix .. 'leaveserver')) then
		if message.author.id == CHRONOMLY or message.author.id == ROMTYPO or message.author.id == JDENDER or message.author.id == SPACEX or message.author.id == TJDOESCODE then
		local guild = client:getGuild(arg)
		guild:leave()
		end
		if message.author.id ~= CHRONOMLY and message.author.id ~= ROMTYPO and message.author.id ~= JDENDER and message.author.id ~= SPACEX and message.author.id ~= TJDOESCODE then
			message.channel:sendMessage('```Error2.1``````You do not have Role: Dev```')
			print(string.format('%s tried to use s.leaveserver', message.author.id))
			print(arg)
		end
	end

	if cmd == (string.format(prefix .. 'announce')) then 
		if message.author.id == CHRONOMLY or message.author.id == ROMTYPO or message.author.id == JDENDER or message.author.id == SPACEX or message.author.id == TJDOESCODE then
		local channel = client:getTextChannel("282977399761666059")
		channel:sendMessage(string.format('**MESSAGE FROM THE DEV, %s**', message.author.username))channel:sendMessage(arg)
		end
		if cmd == (string.format(prefix .. 'announce')) then
		if message.author.id ~= CHRONOMLY and message.author.id ~= ROMTYPO and message.author.id ~= JDENDER and message.author.id ~= SPACEX and message.author.id ~= TJDOESCODE then
			message.channel:sendMessage('```Error 404.5``````You do not have Role: Dev```')
			print(string.format('%s tried to use s.announce to send', message.author.id))
			print(arg)
		end
	end
	end
	
	if cmd == (string.format(prefix .. 'sendall')) then
		if message.author.id == CHRONOMLY or message.author.id == ROMTYPO or message.author.id == JDENDER or message.author.id == SPACEX or message.author.id == TJDOESCODE then
		message.channel:sendMessage('')
		for guild in client.guilds do
		guild.defaultChannel:sendMessage(arg)
		print('Message Sent to all servers')
		end
		end
		if message.author.id ~= CHRONOMLY and message.author.id ~= ROMTYPO and message.author.id ~= JDENDER and message.author.id ~= SPACEX and message.author.id ~= TJDOESCODE then
			message.channel:sendMessage('```Error 404.5``````You do not have Role: Dev```')
			print(string.format('%s tried to use s.sendall to send', message.author.id))
			print(arg)
		end
	end
	
	if cmd == (string.format(prefix .. 'game')) then
		if message.author.id == CHRONOMLY or message.author.id == ROMTYPO or message.author.id == JDENDER or message.author.id == SPACEX or message.author.id == TJDOESCODE then
			client:setGameName(arg)message.channel:sendMessage(string.format([[Set "playing status" to:
			%s
			]], arg))
			print('s.game command was used')
		end
		if message.author.id ~= CHRONOMLY and message.author.id ~= ROMTYPO and message.author.id ~= JDENDER and message.author.id ~= SPACEX and message.author.id ~= TJDOESCODE then
			message.channel:sendMessage('```Error 404.5``````You do not have Role: Dev```')
			print(string.format('%s tried to use s.game to set', message.author.id))
			print(arg)
		end
	end
	
	if message.content == (string.format(prefix .. 'reboot')) then
		if message.author.id == CHRONOMLY or message.author.id == ROMTYPO or message.author.id == JDENDER or message.author.id == SPACEX or message.author.id == TJDOESCODE then
		message.channel:sendMessage(':wave: BRB!')
		client:stop(true)
		end
		if message.author.id ~= CHRONOMLY and message.author.id ~= ROMTYPO and message.author.id ~= JDENDER and message.author.id ~= SPACEX and message.author.id ~= TJDOESCODE then
			message.channel:sendMessage('```Error2.1``````You do not have Role: Dev```')
			print(string.format('%s tried to use s.reboot', message.author.id)) 
		end
	end
	
	
	if cmd == (string.format(prefix .. 'guildlist')) then
		if message.author.id == CHRONOMLY or message.author.id == ROMTYPO or message.author.id == JDENDER or message.author.id == SPACEX or message.author.id == TJDOESCODE then
			for guild in client.guilds do
			message.channel:sendMessage("`" .. guild.name .. " / " .. guild.id .. "`")
			end
			print("All done!")
		end
		if message.author.id ~= CHRONOMLY and message.author.id ~= ROMTYPO and message.author.id ~= JDENDER and message.author.id ~= SPACEX and message.author.id ~= TJDOESCODE then
			message.channel:sendMessage('```Error2.1``````You do not have Role: Dev```')
			print(string.format('%s tried to use s.guildlist', message.author.id)) 
		end
	end

	if cmd == (string.format(prefix .. 'changelog')) then
		local file = assert(io.popen('git shortlog', 'r'))
		local changes = file:read('*all')
		file:close()
		message.channel:sendMessage {
  			embed = {
    			title = "Changelog <:github:295243074353758209>",
			fields = {
				{name = "__Github__", value = string.format("```%s```",changes), inline = true}
			},
    			color = ccolor,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = "ROM is best, ROM is life"}
 	 		}
		}
	end

	
end)

local f = io.open("LOGIN_TOKEN", "rb")
    local content = f:read("*all")
local token = string.gsub(content, "%s+", "")
    f:close()
client:run(token)
