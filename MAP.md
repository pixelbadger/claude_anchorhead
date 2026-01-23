# Anchorhead Map

This map shows the locations discovered during gameplay, with connections between them.

## Discovered Locations

```mermaid
graph TD
    A[Outside Real Estate Office<br/>Cul-de-sac]
    B[Alley<br/>Garbage-choked]
    C[Back Room<br/>Filing Cabinets]
    D[Real Estate Office<br/>Main Office]
    E[Narrow Lane<br/>Twisting Street]
    F[Whateley Bridge<br/>Over Miskaton River]
    G[Town Square<br/>Stone Obelisk]
    H[Dark Street<br/>Shadowy]
    I[Asylum Courtyard<br/>Grim & Shadowed]
    J[Danvers Asylum<br/>CLOSED]
    K[Courthouse<br/>CLOSED]
    L[Watering Hole<br/>Pub - Hostile Locals]
    M[Twisting Lane<br/>Dead End - Brick Wall]
    N[Dark Alley<br/>Dead End SW of Square]
    O[Riverbank Street<br/>By Miskaton]
    P[Vacant Lot<br/>Weeds & Mattress]
    Q[Pier<br/>By the Ocean]
    R[Misty Avenue<br/>Cold & Clammy]
    S[Birch Woods Lane<br/>Winding Path]
    T[Abandoned Church Yard<br/>Broken Fence]

    A -->|east<br/>locked door| D
    A -->|west| E
    A -->|southeast| B

    B -->|climb & enter<br/>transom window| C

    C -->|west| D

    D -->|east| C
    D -->|west<br/>unlocked & exit| A

    E -->|east| A
    E -->|south| F
    E -->|north<br/>steps down| L
    E -->|northwest<br/>up hill| M

    M -->|southwest| E

    L -->|south| E

    F -->|north| E
    F -->|south| G

    G -->|north| F
    G -->|south| K
    G -->|west| H
    G -->|east| O
    G -->|southwest| N

    N -->|northeast| G

    H -->|east| G
    H -->|south| I

    I -->|north| H
    I -->|south| J

    O -->|west| G
    O -->|east| P
    O -->|south| R

    P -->|west| O
    P -->|southeast| Q

    Q -->|northwest| P

    R -->|north| O
    R -->|south| S

    S -->|north| R
    S -->|east| T

    T -->|west| S

    style C fill:#90EE90
    style D fill:#90EE90
    style L fill:#90EE90
    style J fill:#FFB6C6
    style K fill:#FFB6C6
    style M fill:#FFB6C6
    style N fill:#FFB6C6
```

## Legend

- **Green**: Accessible/visited indoor locations
- **Red**: Closed/inaccessible/dead-end locations
- **Blue**: Standard outdoor locations

## Key Discoveries

### Outside Real Estate Office
- Starting location
- Narrow cul-de-sac with real estate office to the east
- Alley to southeast (used to enter office)

### Alley
- Garbage-choked alley with tall wooden fence
- Contains metal garbage cans and transom window
- Pushed garbage can to wall and climbed to reach window
- Alternative entrance to the real estate office

### Real Estate Office (Back Room)
- Filing cabinets with hundreds of property records
- Too many files to browse without specific search
- Accessed via transom window

### Real Estate Office (Main Office)
- **Answering machine**: Mysterious message with voice whispering "Verlac" through static
- Locked desk drawer (could not open)
- Papers scattered on desk (nothing useful found)
- Cold, half-finished coffee (Miss Benson left suddenly)
- Office was deserted and locked

### Town Square
- Central location with stone obelisk monument
- **Obelisk**: 15 feet tall, covered in worn hieroglyphs, iron ring embedded near top
- Municipal courthouse (closed for the day)
- Multiple exits to all sections of town

### Whateley Bridge
- Ancient, crumbling bridge over Miskaton River
- Moss-eaten flagstones, occasionally drops mortar into water
- Connects north and south sections of city

### Danvers Asylum
- White-washed edifice with barred windows
- Motto: "Health, Discipline, Tranquillity" with caduceus symbol
- Oppressive, claustrophobic atmosphere
- Currently closed for the day

### Watering Hole (Pub)
- Dank drinking hole lit by oil-burning lanterns
- Mill workers and fishermen drinking in silence
- **Important**: Mentioned Verlac family - locals became hostile and silent
- One local warned: "Some things best left alone by outsiders"
- **Found**: Flask of rotgut spirits under a table

### Pier
- Wooden pier at ocean's edge
- Few boats tied up (fishing industry mostly dead)
- **Found**: Old tin of fish oil from Skagen, Denmark

### Abandoned Church
- Dark, abandoned building in the woods
- Wrought-iron fence bent at crazy angles
- Overgrown with weeds
- Path leads around to the southeast (not explored)

## Current Status

**Location**: Outside Real Estate Office (Cul-de-sac)

**Inventory**:
- Wedding ring (worn)
- Trenchcoat (worn)
- Clothes (worn)
- Umbrella (in hand)
- Flask of rotgut spirits (closed) - found in pub
- Old tin of fish oil (closed) - found at pier

**Next Steps**: Waiting for Michael to return and pick me up

## Unexplored Areas

- Path around abandoned church to the southeast
- South continuation of Birch Woods Lane (deeper into forest)
- Southwest dirt road from Misty Avenue
- Steps down to riverbank (gate on Riverbank Street)
- The Verlac house (destination - have not received keys yet)

## Notes

- Miss Benson (real estate agent) is missing - office was locked and deserted
- No keys found in the office (desk drawer locked)
- The Verlac family name causes fear and hostility among locals
- Town has oppressive, decaying atmosphere
- Many buildings are closed or abandoned
- Weather: cold rain, green lightning in storm clouds
