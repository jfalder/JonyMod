SMODS.Atlas{
    key = 'jony_card',
    path = 'jony.png',
    px = 35,
    py = 45,
}


SMODS.Consumable({
    key = "jony_card",
    set = "Tarot",
    object_type = "Consumable",
    name = "jonyworld",
    loc_txt = {
        name = "jonyworld",
        text={
        "Creates a random",
        "{C:attention}JonyMod Joker{}",
        "{C:inactive}(must have room){}",
        },
    },
	
	
	pos = {x=0, y= 0},
	order = 99,
	atlas = "jony_card",
    unlocked = true,
    cost = 4,

    use = function(self, card, area, copier)
        local card = create_card("jonymodaddition", G.Jokers, nil, nil, nil, nil, nil, 'jonyworld')
        card:add_to_deck()
        G.jokers:emplace(card)
    end,

    can_use = function(self, card)
        if #G.jokers.cards < G.jokers.config.card_limit then
            return true
        end
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})