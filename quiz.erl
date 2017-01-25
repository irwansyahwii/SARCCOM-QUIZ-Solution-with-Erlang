- module(quiz) .
- export([foo/1]) .

foo(Sentence) ->
    StickerDict = dict:new(),
    NewSticker = initSticker(StickerDict),
    calculateSticker(Sentence, NewSticker).

calculateSticker([], StickerDict) ->
    {ok, StickerCount} = dict:find(stickerCount, StickerDict),
    io:format("~p", ["Finished calculating sticker:"]),
    io:write(StickerCount);

calculateSticker([H | T], StickerDict) when H =/= 32 ->
    Lower = list_to_atom([string:to_lower(H)]),

    try
        FindResult = dict:find(Lower, StickerDict),
        {ok, CharCount} = FindResult,
        NewSticker = useChar(Lower, CharCount, StickerDict),
        calculateSticker(T, NewSticker)
    catch
        _:_ -> "INVALID CHAR"
    end;
    
calculateSticker([H | T], StickerDict) when H =:= 32 -> calculateSticker(T, StickerDict).
    

useChar(Lower, Count, StickerDict) 
    when Count > 0 -> dict:store(Lower, Count - 1, StickerDict);

useChar(Lower, Count, StickerDict) 
    when Count =:= 0 -> addNewSticker([i,n,d,o,n,e,s,i,a], StickerDict);

useChar(Lower, Count, StickerDict) 
    when Count < 0 -> StickerDict.


addNewSticker([H | T], StickerDict) ->
    {ok, CharCount} = dict:find(H,StickerDict),
    StickerDict2 = dict:store(H, CharCount + 1, StickerDict),
    NewSticker = addNewSticker(T, StickerDict2),
    NewSticker;

addNewSticker([], StickerDict)  ->
    {ok, StickerCount} = dict:find(stickerCount,StickerDict),
    % io:write(StickerCount),
    dict:store(stickerCount, StickerCount + 1, StickerDict).
    

initSticker(StickerDict) ->
    StickerDict2 = dict:store(i, 2, StickerDict),
    StickerDict3 = dict:store(n, 2, StickerDict2),
    StickerDict4 = dict:store(d, 1, StickerDict3),
    StickerDict5 = dict:store(o, 1, StickerDict4),
    StickerDict7 = dict:store(e, 1, StickerDict5),
    StickerDict8 = dict:store(s, 1, StickerDict7),
    StickerDict10 = dict:store(a, 1, StickerDict8),
    dict:store(stickerCount, 1, StickerDict10).
