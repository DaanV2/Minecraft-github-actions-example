function setup
replaceitem entity @a slot 0 diamond_sword 1 0 { "minecraft:can_destroy": { "blocks": [ "grass" ] }, "minecraft:can_place_on": { "blocks": [ "grass" ] }, "minecraft:lock_in_inventory":{}, "minecraft:keep_on_death":{}, "minecraft:lock_in_slot":{} }

scoreboard objectives add test dummy "Value"
execute @e[scores={test=..-1}] ~ ~ ~ 