--- STEAMODDED HEADER
--- MOD_NAME: JonyMod
--- MOD_ID: JonyMod
--- MOD_AUTHOR: Jonah Falder
--- MOD_DESCRIPTION: hi
--- PREFIX: jony
----------------------------------------------------------
----------- MOD CODE -------------------------------------


---Sexy Sam

SMODS.Atlas{
    key = 'Sam',
    path = 'Sam.png',
    px = 350,
    py = 520,
}


SMODS.Joker{
    key = 'Sam',
    loc_txt= {
        name = 'Sexy Sam',
        text = {
            'This Joker Gains {X:mult,C:white}X#1#{} Mult when a {C:attention}Royal Flush{} is Played',
            '(Currently : {X:mult,C:white}X#2#{} Mult)'  
        }
    },
    atlas = "Sam",
    rarity = 1,
    cost = 6,
    pools = {["jonymodaddition"] = true},

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x = 0, y = 0},
    
    config = { 
        extra = { 
            add = 1,
            xmult = 1.5 
        } 
    },

    loc_vars = function(self, info_queue, center)
        return { vars = {center.ability.extra.add, center.ability.extra.xmult} }
    end,

    calculate = function(self, card, context)
        -- Only trigger on scoring hands (before scoring)
        if context.joker_main and next(context.poker_hands['Straight Flush']) then
            _royal = true
            for i = 1, #G.play.cards do
                local _rank = G.play.cards[i]:get_id()
                if _rank < 10 then
                    _royal = false
                end
                if _royal == true then
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.add
                    return {
                        message = "All in!",
                        xmult = card.ability.extra.xmult
                    }
                end
                
            end
        end

        -- Always apply multiplier if joker_main
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

---KSAC Hours

SMODS.Atlas{
    key = 'KSAC',
    path = 'Lucas.png',
    px = 200,
    py = 250,
}


SMODS.Joker{
    key = 'KSAC',
    loc_txt = {
        name = 'KSAC Hours?',
        text = {
            'If the KSAC is Open, {C:red}+#1#{} Mult',
        }
    },
    atlas = 'KSAC',
    rarity = 1,
    cost = 4,
    pools = {["jonymodaddition"] = true},

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    config = { extra = {mult = 25}},


    loc_vars = function(self, info_queue, center)
        return { vars = {center.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        local t = os.date("*t")
        local weekday = t.wday
        local hour = t.hour
        local min = t.min

        local is_weekday = weekday >= 2 and weekday <= 6

        local after_open = (hour >= 6) or (hour == 5 and min >= 30)
        local before_close = hour < 23

        local ksac_open = is_weekday and after_open and before_close

        if context.open then return end

        if ksac_open and context.joker_main then
            return {
                message = "KSAC OPEN!",
                mult = card.ability.extra.mult
            }
        end
    end,


    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
   
}

---ShangChi

SMODS.Atlas{
    key = "ShangChi",
    path = "shang-chi.png",
    px = '500',
    py = '500',
}

SMODS.Joker{
    key = 'ShangChi',
    loc_txt = {
        name = "Shang-Chi",
        text = { "Removes {C:attention}10%{} of required score from the current blind"},
    },
    atlas = 'ShangChi',
    rarity = 1,
    cost = 6,
    pools = {["jonymodaddition"] = true},

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y=0},

    calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.blind.chips = math.floor(G.GAME.blind.chips * 0.9)
        end
    end,
}

---Dirk Nowitzki





---Triple Swipe
SMODS.Atlas{
    key = "Triple",
    path = "TripleSwipe.png",
    px= 650,
    py = 1050,
}


SMODS.Joker{
    key = 'Triple',
    loc_txt = {
        name = "Triple Swipe",
        text = {"This Joker Gains {C:red}+#1#{} Mult ",
                "when a {C:attention}Three of a Kind {}",
                "is played {C:attention}3 Times{} in a row",
                "Currently: {C:red}+#2#{} Mult"}
    },
    atlas = 'Triple',
    rarity = 1,
    cost = 6,
    pools = {["jonymodaddition"] = true},

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y=0},

    config = { 
        extra = { 
            add = 33,
            mult = 0,
            count = 0 
        } 
    },



    loc_vars = function(self, info_queue, center)
        return { vars = {center.ability.extra.add, center.ability.extra.mult} }
    end,

    calculate = function(self, card, context)
        if context.before then 
           
            if card.ability.extra.count == 2 and next(context.poker_hands["Three of a Kind"]) then 
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
                card.ability.extra.count = 0
                return {
                    message = "TRIPLE SWIPE!"
                }
        
            end
           
            if context.poker_hands and next(context.poker_hands["Three of a Kind"]) then
                card.ability.extra.count = card.ability.extra.count + 1
                local temp = card.ability.extra.count
                temp = tostring(temp)
                return{
                    message = temp .."!"
                }
            else 
                card.ability.extra.count = 0
                return{
                    message = 'Reset!'  
                }
            end

            
            
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end


    end,
}



---Mr. President

SMODS.Atlas{
    key = "President",
    path = "President.png",
    px= 450,
    py = 750,
}


SMODS.Joker{
    key = 'President',
    loc_txt = {
        name = "Mr.President",
        text = {" {X:mult,C:white}^2{} to your Mult",
                "{C:inactive}One Body Who?{}"}
    },
    atlas = 'President',
    rarity = 4,
    cost = 6,
    pools = {["jonymodaddition"] = true},

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y=0},

    calculate = function(self, card, context)
       if context.joker_main then
            return {
                message = '^2',
                xmult = mult
            }
        end
    end,
}

---Cucumber?

SMODS.Atlas{
    key = 'Cucumber',
    path = 'Cucumber.png',
    px = 450,
    py = 750,
}


SMODS.Joker{
    key = 'Cucumber',
    loc_txt = {
        name = "Cucumber?",
        text = {"For Each Sister Wing Joker {C:red}+#1#{} Mult",
                "Currently {C:red}+#2#{} Mult"}
    },
    atlas = 'Cucumber',
    rarity = 1,
    cost = 6,
    pools = {["jonymodaddition"] = true, ["SisterWing"] = true},

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y=0},

    config = { 
        extra = { 
            mult = 10,
            multtotal = 0,
        } 
    },
    
    
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.mult, center.ability.extra.multtotal} } 
	end,


    calculate = function(self, card, context)
        siscount = 0
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.SisterWing then
                siscount = siscount + 1
            end
        end
        card.ability.extra.multtotal =  siscount * card.ability.extra.mult
        if context.joker_main then
            return {
                color = G.C.RED,
                message = "+".. card.ability.extra.multtotal,
                mult_mod = card.ability.extra.multtotal
            }
        end
    end,
}


---Balkema

SMODS.Atlas{
    key = 'Balkema',
    path = 'Balkema.png',
    px = 100,
    py = 150,
}

SMODS.Joker{
    key = 'Balkema',
    loc_txt = {
        name = "Luke Balkema",
        text = {"{X:mult,C:white}x3.5{} Mult",
                "Crashes your Game if you lose",
                "{C:inactive}I'm just making the game more fun!{}"}
    },


    atlas = 'Balkema',
    rarity = 3,
    cost = 6,
    pools = {["jonymodaddition"] = true},

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y=0},



    calculate = function(self, card, context)
        if context.joker_main then
            return{
                xmult = 3.5
            }
        end

        if context.game_over then
            local crash = nil
            crash.do_it = true
        end
    end,
}