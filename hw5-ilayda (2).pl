man(ali).
man(mehmet).
man(yunus).
woman(elif).
woman(nelin).
woman(zeynep).

% List of the locations
location(bathroom).
location(diningroom).
location(kitchen).
location(livingroom).
location(pantry).
location(study).

% List of the instruments
instrument(hammer).
instrument(weldingmachine).
instrument(gun).
instrument(knife).
instrument(chemical).
instrument(handsaw).

suspect(X) :- man(X).
suspect(X) :- woman(X).

writevals(Bathroom, Diningroom, Kitchen, Livingroom, Pantry, Study, Hammer, Weldingmachine, Gun, Knife, Chemical, Handsaw) :-
  
  % Print the location listings
  nl, write(" Locations "), nl,
  write("Bathroom: "), write(Bathroom), nl,
  write("Dining Room: "), write(Diningroom), nl,
  write("Kitchen: "), write(Kitchen), nl,
  write("Living Room: "), write(Livingroom), nl,
  write("Pantry: "), write(Pantry), nl,
  write("Study: "), write(Study), nl,

  % Print the instrument listings
  nl, write(" Instruments "), nl,
  write("Bag: "), write(Hammer), nl,
  write("Firearm: "), write(Weldingmachine), nl,
  write("Gas: "), write(Gun), nl,
  write("Knife: "), write(Knife), nl,
  write("Poison: "), write(Chemical), nl,
  write("Rope: "), write(Handsaw), nl.

% All of the suspects are unique
init_suspects(Suspect1, Suspect2, Suspect3, Suspect4, Suspect5, Suspect6) :-
  suspect(Suspect1), suspect(Suspect2), suspect(Suspect3), suspect(Suspect4), suspect(Suspect5), suspect(Suspect6),
  \+ Suspect1 = Suspect2, \+ Suspect1 = Suspect3, \+ Suspect1 = Suspect4, \+ Suspect1 = Suspect5, \+ Suspect1 = Suspect6,
  \+ Suspect2 = Suspect3, \+ Suspect2 = Suspect4, \+ Suspect2 = Suspect5, \+ Suspect2 = Suspect6,
  \+ Suspect3 = Suspect4, \+ Suspect3 = Suspect5, \+ Suspect3 = Suspect6,
  \+ Suspect4 = Suspect5, \+ Suspect4 = Suspect6,
  \+ Suspect5 = Suspect6.

% Find the murderer
murderer(X) :-
  % Initialise the scenario
  init_suspects(Bathroom, Diningroom, Kitchen, Livingroom, Pantry, Study),
  init_suspects(Hammer,Weldingmachine, Gun, Knife, Chemical, Handsaw),
  
  % Clue 1
  % In the kitchen, the man was not found with the knife, hammer, or welding machine. 
  % Which instrument, other than gun, was found in the kitchen? Chemical or handsaw
  man(Kitchen),
  \+ Kitchen = Hammer, \+ Kitchen = Knife, \+ Kitchen = Weldingmachine, \+ Kitchen = Gun,
  
  % Clue 2
  % Elif was either in the study or the bathroom;
  % Zeynep was in the other. Which room was Elif found in? 
  woman(Study), woman(Bathroom), 
  \+ Diningroom = elif, \+ Kitchen = elif, \+ Livingroom = elif, \+ Pantry = elif,
  \+ Diningroom = zeynep, \+ Kitchen = zeynep, \+ Livingroom = zeynep, \+ Pantry = zeynep,

  % Clue 3
  % The person with the hammer was not in the bathroom nor the dining room; also,
  %  this person was not Elif nor Ali. Then, who had the hammer in that room?
  \+ Hammer = elif, \+ Hammer = ali,
  \+ Bathroom = Hammer, \+ Diningroom = Hammer,

  % Clue 4
  % The welding machine was found in the study with a woman. Who was it?

    woman(Study),
    Weldingmachine = Study,

  % Clue 5
  % The instrument found in the living room was with either Mehmet or Ali. 
    man(Livingroom), \+ Livingroom = yunus,

  % Clue 6
  % The knife was not in the dining room. Where was it?
  \+ Diningroom = Knife,

  % Clue 7
  % Zeynep was not with the instrument found in the study nor the pantry. 
  \+ Pantry = zeynep, \+ Study = zeynep,

  % Clue 8
  % Ali was found with the gun.
  Gun = ali,

  % Clue 9
  % the safety box was broken by a handsaw in the pantry.
   Pantry = Handsaw, Pantry = X,

  % Print the result
  write(X), write(" is the murderer"), nl,

  % Print the locations and weapons of the rest
  writevals(Bathroom, Diningroom, Kitchen, Livingroom, Pantry, Study, Hammer, Weldingmachine, Gun, Knife, Chemical, Handsaw).
