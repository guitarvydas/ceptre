fight_auto:

inputs:
`try_fight`
`fight_in_progress`
`monster_hp MHP`
`player's weapon power D`
`monster size Size`
`player's health HP`

calculated values:
`MHP' = random MHP - D` && MHP > 0
`MHP' = random MHP - D` && MHP <= 0
`player's health HP - monster's size Size` > 0
`player's health HP` > 0
`player's health HP` <= 0




