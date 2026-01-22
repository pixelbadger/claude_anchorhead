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
    L[Watering Hole<br/>NOT VISITED]
    M[Twisting Lane<br/>NOT VISITED]

    A -->|east<br/>locked door| D
    A -->|west| E
    A -->|southeast| B

    B -->|climb & enter<br/>transom window| C

    C -->|west| D

    D -->|east| C
    D -->|west<br/>unlock & exit| A

    E -->|east| A
    E -->|south| F
    E -->|north<br/>steps down| L
    E -->|northwest<br/>up hill| M

    F -->|north| E
    F -->|south| G

    G -->|north| F
    G -->|south| K
    G -->|west| H

    H -->|east| G
    H -->|south| I

    I -->|north| H
    I -->|south| J

    style C fill:#90EE90
    style D fill:#90EE90
    style J fill:#FFB6C6
    style K fill:#FFB6C6
    style L fill:#D3D3D3
    style M fill:#D3D3D3
```

## Legend

- **Green**: Accessible indoor locations
- **Red**: Closed/inaccessible locations
- **Gray**: Mentioned but not yet visited
- **Blue**: Standard locations

## Key Discoveries

### Outside Real Estate Office
- Starting location
- Narrow cul-de-sac with real estate office to the east
- Alley to southeast (key to entering)

### Alley
- Contains garbage cans and transom window
- Used garbage can to climb and enter through window
- Alternative entrance to the real estate office

### Real Estate Office (Back Room)
- Filing cabinets with property records
- **Found**: Verlac property keys (house key + cellar key)
- Verlac file was cleaned out (suspicious)

### Real Estate Office (Main Office)
- Answering machine with mysterious message
- Voice whispering "Verlac" through static
- Locked desk drawer
- Office deserted with cold coffee

### Town Square
- Central location with stone obelisk monument
- Obelisk has hieroglyphs and iron ring near top
- Municipal courthouse (closed)
- Multiple exits to explore

### Whateley Bridge
- Ancient, crumbling bridge over Miskaton River
- Connects north and south sections of city

### Danvers Asylum
- White-washed building with barred windows
- Currently closed
- Ominous atmosphere

## Current Status

**Location**: Asylum Courtyard (outside Danvers Asylum)

**Inventory**:
- Wedding ring (worn)
- Trenchcoat (worn)
- Clothes (worn)
- Umbrella (in hand)
- Keyring with 2 keys:
  - Key to the house
  - Key to the cellar

## Unexplored Areas

- Watering hole (north from Narrow Lane)
- Twisting lane up the hill (northwest from Narrow Lane)
- Avenue east from Town Square
- Dark alley southwest from Town Square
- The Verlac house (destination - need to find it!)
