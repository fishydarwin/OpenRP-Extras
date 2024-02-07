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
# OpenRP Extras, World Scripts
#

## Handles OpenRP reloading
orpextras_world_overrides:
    debug: false
    type: world
    events:
        after server start:
        - run orpextras_reload_config
        after reload scripts:
        - run orpextras_reload_config
        after command:
        - if <context.command.to_lowercase> == openrp || <context.command.to_lowercase> == orp:
            - if <context.args.get[1].to_lowercase> == reload:
                - run orpextras_reload_config


## Handles OpenRP chat extra features.
orpextras_world_chat:
    debug: false
    type: world
    events:
        on internal bukkit event event:openrp.chat.events.ORPChatEvent:
        #
        - define event <context.reflect_event>
        - define message <[event].read_field[message]>
        - define channel <[event].read_field[channel]>
        - define player <[event].read_field[player]>
        # Force Caps
        - if <yaml[openrp_chat].contains[channels.<[channel]>.orpextras-force-caps]>:
            - define force_caps <yaml[openrp_chat].read[channels.<[channel]>.orpextras-force-caps]>
            - if <[force_caps]>:
                - reflectionset object:<[event]> field:message value:<[message].to_uppercase>
        # Language Channels
        - if <[channel].starts_with[language]>:
            - define language <[message].strip_color.split.get[1].to_lowercase>
            - if !<[player].flag[orpextras_languages].contains[<[language]>].if_null[false]>:
                - narrate "<&c>You do not speak <[language].to_sentence_case>." player:<[player]>
                - determine cancelled
        #
        on internal bukkit event event:openrp.chat.events.ORPChatPreprintEvent:
        #
        - define event <context.reflect_event>
        - define message <[event].read_field[message]>
        - define channel <[event].read_field[channel]>
        - define player <[event].read_field[sender]>
        - define target <[event].read_field[player]>
        # Language Channels
        - if <[channel].starts_with[language]>:
            - define language <[message].split.get[1].strip_color.to_sentence_case>
            - define final_message <[message].split.remove[1].space_separated>
            - if <[target].flag[orpextras_languages].contains[<[language].to_lowercase>].if_null[false]>:
                - define language_format <yaml[openrp_chat].read[channels.<[channel]>.orpextras-language-known-format].parse_color>
                - define language_format <[language_format].replace[{message}].with[<[final_message]>]>
                - define language_format <[language_format].replace[{language}].with[<[language]>]>
            - else:
                - define language_format <yaml[openrp_chat].read[channels.<[channel]>.orpextras-language-unknown-format]>
                - define language_format <[language_format].replace[{language}].with[<[language]>]>
            - reflectionset object:<[event]> field:message value:<[language_format]>
        #

## Handles OpenRP /character set extra features.
orpextras_world_description:
    debug: false
    type: world
    events:
        on internal bukkit event event:openrp.descriptions.events.ORPDescriptionsChangeEvent:
        #
        - define event <context.reflect_event>
        - define uuid <[event].read_field[uuid]>
        - define field <[event].read_field[field]>
        - define value <[event].read_field[value]>
        - define player <player[<[uuid]>]>
        # Regex Validator
        - if <yaml[openrp_desc].contains[fields.<[field]>.orpextras-regex]>:
            - define regex <yaml[openrp_desc].read[fields.<[field]>.orpextras-regex]>
            - if !<[value].regex_matches[<[regex]>]>:
                - narrate "<&c>You cannot use <[value]> in your <[field]>." player:<[player]>
                - determine cancelled
        #
