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
# OpenRP Extras, Tasks and Procedures
#

## Run to reload OpenRP Config in Denizen.
## Configs: <yaml[openrp_chat/desc/rolls/time]>
orpextras_reload_config:
    debug: false
    type: task
    script:
    #
    - ~yaml load:../OpenRP/chat/config.yml id:openrp_chat
    - ~yaml load:../OpenRP/descriptions/config.yml id:openrp_desc
    #- ~yaml load:../OpenRP/rolls/config.yml id:openrp_rolls
    #- ~yaml load:../OpenRP/time/config.yml id:openrp_time
    #
    - announce to_console "[OpenRP] Reloaded OpenRP-Extras."
