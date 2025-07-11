SMODS.Atlas {
    key = "freak_seal",
    path = "freak_seal.png",
    px = 25,
    py = 20,
}


SMODS.Seal {
    name = 'freak_seal',
    key = 'freak_seal',
    loc_txt = {
        label = 'FREAK SEAL',
        name = 'FREAK SEAL',
        text = {  "Work in Progress",
                    "Check Again Later",
        }
    },


    atlas = 'freak_seal',
    pos = {x=0,y=0},

    calculate = function (self, card, context)
        if context.main_scoring then
            return {message ='yup'}
        end

    end,
}