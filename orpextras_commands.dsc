#
# This file is part of OpenRP Extras.
#
# OpenRP Extras is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# OpenRP Extras is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# See the GNU General Public License for more details.
#

#
# OpenRP Extras, In-Game Commands
#

# /addlanguage - Add a language to a player.
orpextras_command_addlanguage:
    debug: false
    type: command
    name: addlanguage
    description: Add a language to a player.
    usage: /addlanguage (player) (language)
    aliases:
    - addlang
    - langadd
    permission: orpextras.command.addlanguage
    tab completions:
        1: <server.online_players.parse[name]>
        2: <&lt>language<&gt>
    script:
    - if <context.args.size> < 2:
        - narrate "<&c>Invalid use. Please try /<context.alias> (player) (language)"
        - stop
    - define player <server.match_offline_player[<context.args.get[1]>].if_null[null]>
    - if <[player]> == null:
        - narrate "<&c>Player <[player].name> is invalid or has never joined before."
        - stop
    - define language <context.args.get[2].to_lowercase>
    - if <[player].flag[orpextras_languages].if_null[<list[]>].contains[<[language]>]>:
        - narrate "<&c><[player].name> already knows <[language].to_sentence_case>."
        - stop
    - flag <[player]> orpextras_languages:<[player].flag[orpextras_languages].if_null[<list[]>].include[<[language]>]>
    - narrate "<&a>Now <&e><[player].name> <&a>can speak <&e><[language].to_sentence_case><&a>."

# /removelanguage - Remove a language from player.
orpextras_command_removelanguage:
    debug: false
    type: command
    name: removelanguage
    description: Remove a language from a player.
    usage: /removelanguage (player) (language)
    aliases:
    - removelang
    - langremove
    permission: orpextras.command.removelanguage
    tab completions:
        1: <server.online_players.parse[name]>
        2: <&lt>language<&gt>
    script:
    - if <context.args.size> < 2:
        - narrate "<&c>Invalid use. Please try /<context.alias> (player) (language)"
        - stop
    - define player <server.match_offline_player[<context.args.get[1]>].if_null[null]>
    - if <[player]> == null:
        - narrate "<&c>Player <[player].name> is invalid or has never joined before."
        - stop
    - define language <context.args.get[2].to_lowercase>
    - if !<[player].flag[orpextras_languages].if_null[<list[]>].contains[<[language]>]>:
        - narrate "<&c><[player].name> does not yet know <[language].to_sentence_case>."
        - stop
    - flag <[player]> orpextras_languages:<[player].flag[orpextras_languages].if_null[<list[]>].exclude[<[language]>]>
    - narrate "<&7>Now <&e><[player].name> <&7>can no longer speak <&e><[language].to_sentence_case><&7>."

# /languages - Checks what languages a player speaks.
orpextras_command_languages:
    debug: false
    type: command
    name: languages
    description: Shows the languages a player speaks.
    usage: /languages (player)
    permission: orpextras.command.languages
    tab completions:
        1: <server.online_players.parse[name]>
    script:
    - if <context.args.size> < 1:
        - narrate "<&c>Invalid use. Please try /<context.alias> (player)"
        - stop
    - define player <server.match_offline_player[<context.args.get[1]>].if_null[null]>
    - if <[player]> == null:
        - narrate "<&c>Player <[player].name> is invalid or has never joined before!"
        - stop
    - define languages <[player].flag[orpextras_languages].if_null[<list[]>]>
    - if <[languages].is_empty>:
        - narrate "<&a><[player].name> does not speak any additional language."
    - else:
        - narrate "<&a><[player].name> can use: <&e><[languages].formatted>"
